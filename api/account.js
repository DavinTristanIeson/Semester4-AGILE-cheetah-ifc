const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const db = require("./db.js");

const { userIsCustomer } = require("./middleware.js");

function validateAccountPayload(requireAllFields){
  return function validateAccountPayload(req, res, next) {
    const { email, password, name, gender, telp } = req.body;
    if (requireAllFields){
      if (!email || !password || !name || !telp) {
        res.status(400).json({
          message:
            "Expecting the following fields: email, password, name, gender, telp",
        });
        return;
      }
    }
    const errors = [];
    if (requireAllFields || email){
      if (email.length == 0) errors.push("Email harus diisi");
      else if (
        !email.match(
          /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$/
        )
      )
        errors.push("Format email tidak sesuai");
    }

    if (requireAllFields || password){
      if (password.length < 8)
        errors.push("Password harus terdiri dari minimal 8 karakter");
    }

    if (requireAllFields || name){
      if (name.length < 5)
        errors.push("Nama harus terdiri dari minimal 5 karakter");
      else if (!name.match(/^[a-zA-Z]+( [a-zA-Z]+)*$/))
        errors.push(
          "Nama hanya boleh terdiri dari huruf alfabet dan satu spasi antar-kata"
        );
    }

    if (requireAllFields || gender){
      if (gender === null || gender === undefined)
        errors.push("Jenis kelamin harus diisi");
    }

    if (requireAllFields || telp){
      if (telp.length == 0) errors.push("No. telp harus diisi");
      else if (!telp.match(/^[0-9]{10,12}$/))
        errors.push("No. telp harus terdiri dari 10-12 angka");
    }
  
    if (errors.length > 0) {
      res.status(400).json({ message: errors.join(". ") });
      return;
    } else {
      next();
    }
  }
}

function createUserObject(user) {
  return {
    id: user.id,
    email: user.email,
    name: user.name,
    gender: user.gender,
    telp: user.telp,
    isAdmin: false,
  };
}

router.post("/register", validateAccountPayload(true), async (req, res, next) => {
  const { email, password, name, gender, telp, isAdmin = 0 } = req.body;
  try {
    const saltRounds = 10;
    const hash = await bcrypt.hash(password, saltRounds);
    await db.run("INSERT INTO users VALUES (NULL, ?, ?, ?, ?, ?, ?)", [
      email,
      hash,
      name,
      !!gender,
      telp,
      isAdmin,
    ]);
  } catch (err) {
    res
      .status(400)
      .json({ message: "Email tersebut sudah digunakan orang lain." });
    next(err);
    return;
  }

  try {
    const user = await db.get("SELECT * FROM users WHERE email = ?", [email]);
    if (!user) res.status(500).end();
    else {
      req.session.user = {
        id: user.id,
        email: user.email,
        isAdmin: user.isAdmin,
      };
      res.status(201).json(createUserObject(user));
    }
  } catch (err) {
    next(err);
  }
});

async function loginAdmin(req, res, next) {
  const ADMIN_PASSWORD = "adminpass";
  try {
    const { password } = req.body;
    if (password == ADMIN_PASSWORD) {
      req.session.user = {
        id: 0,
        email: "",
        isAdmin: true,
        login: "success",
      };
      res.status(200).json({ message: "Admin Berhasil masuk" });
    } else {
      next();
    }
  } catch (err) {
    next(err);
  }
}

router.post("/login/admin", loginAdmin);

router.post("/login", async (req, res, next) => {
  const { email, password } = req.body;
  if (!email || !password){
    res.status(400).json({ message: "Email dan password harus disediakan!" });
    return;
  }
  try {
    const user = await db.get("SELECT * FROM users WHERE email = ?", [email]);
    if (!user || !(await bcrypt.compare(password, user.password))) {
      res.status(401).json({ message: "Email atau password salah!" });
      return;
    }
    // set user property on session object if login is successful
    req.session.user = {
      id: user.id,
      email: user.email,
      isAdmin: false,
      login: "success",
    };
    res.status(200).json(createUserObject(user));
  } catch (err) {
    next(err);
  }
});

router.post("/logout", (req, res) => {
  if (req.session.user) {
    req.session.destroy((err) => {
      if (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to logout" });
      } else {
        res.status(200).json({ message: "Logged out successfully" });
      }
    });
  } else {
    res.status(400).json({ error: "Session not found" });
  }
});

router.get("/me", (req, res) => {
  if (req.session.user) res.status(200).json(req.session.user);
  else res.status(401).end();
});

router.get("", userIsCustomer, async (req, res) => {
  const user = await db.get("SELECT * FROM users WHERE id = ?", [
    req.session.user.id,
  ]);
  if (!user)
    res.status(404).json({
      message: `Tidak dapat menemukan akun dengan ID ${req.session.user.id}`,
    });
  else res.status(200).json(createUserObject(user));
});

router.delete("", userIsCustomer, async (req, res) => {
  const user = await db.get("SELECT * FROM users WHERE id = ?", [
    req.session.user.id,
  ]);
  if (!req.body.password){
    res.status(400).json({message: "Password tidak diisi!"});
    return;
  }
  if (!user || !(await bcrypt.compare(req.body.password, user.password))) {
    res.status(401).json({ message: "Password salah!" });
    return;
  }

  try {
    await db.run("DELETE FROM users WHERE id = ?", [user.id]);
    res.status(200).json({ message: "Berhasil menghapus akun" });
    req.session.destroy((err) => {
      if (err) console.error(err);
    });
  } catch (err) {
    res
      .status(500)
      .json({ message: "Tidak dapat menghapus akun anda pada saat ini" });
    next(err);
  }
});

router.put(
  "",
  userIsCustomer,
  validateAccountPayload(false),
  async (req, res, next) => {
    const { email, name, gender, telp, password, verify } = req.body;
    const userId = req.session.user.id;
    try {
      let isPasswordMatch = true;
      const user = await db.get("SELECT * FROM users WHERE id = ?", [userId]);
      if (!user) {
        res.status(404).json({ message: "User not found" });
        return;
      }
      if (password) {
        if (!verify) {
          res
            .status(400)
            .json({ message: "Harap masukkan password lama untuk verifikasi" });
          return;
        }
        isPasswordMatch = await bcrypt.compare(verify, user.password);
        if (!isPasswordMatch) {
          res.status(401).json({ message: "Password lama tidak sesuai" });
          return;
        }
      }

      let updatedEmail = email;
      let updatedName = name;
      let updatedGender = gender;
      let updatedTelp = telp;

      if (!updatedEmail) {
        updatedEmail = user.email;
      }
      if (!updatedName) {
        updatedName = user.name;
      }
      if (updatedGender === undefined || updatedGender === null) {
        updatedGender = user.gender;
      }
      if (!updatedTelp) {
        updatedTelp = user.telp;
      }

      if (password && isPasswordMatch) {
        const saltRounds = 10;
        const hashedNewPassword = await bcrypt.hash(password, saltRounds);
        await db.run(
          "UPDATE users SET email = ?, name = ?, gender = ?, telp = ?, password = ? WHERE id = ?",
          [
            updatedEmail,
            updatedName,
            !!updatedGender,
            updatedTelp,
            hashedNewPassword,
            userId,
          ]
        );
      } else {
        await db.run(
          "UPDATE users SET email = ?, name = ?, gender = ?, telp = ? WHERE id = ?",
          [updatedEmail, updatedName, !!updatedGender, updatedTelp, userId]
        );
      }

      const updatedUser = await db.get("SELECT * FROM users WHERE id = ?", [userId]);
      res.status(200).json(updatedUser);
    } catch (err) {
      next(err);
    }
  }
);

module.exports = router;
