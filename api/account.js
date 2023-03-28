const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const db = require("./db.js");

const { userIsCustomer } = require("./middleware.js");

function validateRegister(req, res, next) {
  const { email, password, name, gender, telp } = req.body;
  console.log(req.body);
  if (!email || !password || !name || !telp) {
    res.status(400).json({
      message:
        "Expecting the following fields: email, password, name, gender, telp",
    });
    return;
  }
  const errors = [];
  if (email.length == 0) errors.push("Email harus diisi");
  else if (
    !email.match(
      /^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
    )
  )
    errors.push("Format email tidak sesuai");
  if (password.length < 8)
    errors.push("Password harus terdiri dari minimal 8 karakter");
  if (name.length < 5)
    errors.push("Nama harus terdiri dari minimal 5 karakter");
  else if (!name.match(/^[a-zA-Z0-9]+$/))
    errors.push(
      "Nama hanya boleh terdiri dari huruf alfabet dan angka 0-9 saja"
    );
  if (gender === null || gender === undefined)
    errors.push("Jenis kelamin harus diisi");
  if (telp.length == 0) errors.push("No. telp harus diisi");
  else if (!telp.match(/^[0-9]{10,12}$/))
    errors.push("No. telp harus terdiri dari 10-12 angka");

  if (errors.length > 0) {
    res.status(400).json({ message: errors.join(". ") });
    return;
  } else {
    next();
  }
}

function createUserObject(user) {
  return {
    id: user.id,
    email: user.email,
    name: user.name,
    gender: user.gender == 1,
    telp: user.telp,
    isAdmin: false,
  };
}

router.post("/register", validateRegister, async (req, res, next) => {
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
    console.log(err);
    res
      .status(400)
      .json({ message: "Email tersebut sudah digunakan orang lain." });
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

router.post("/login", async (req, res, next) => {
  try {
    const { email, password } = req.body;
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
  req.session.destroy((err) => {
    if (err) throw err;
  });
  res.status(200).end();
});

router.get("/me", (req, res) => {
  if (req.session.user) res.status(200).json(req.session.user);
  else res.status(401).end();
});
module.exports = router;
