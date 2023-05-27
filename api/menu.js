const express = require("express");
const router = express.Router();
const db = require("./db.js");
const { userIsAdmin } = require("./middleware");

router.get("/", async (req, res) => {
  const { search, limit } = req.query;
  let query = "SELECT * FROM menu";
  let params = [];
  if (search) {
    query += " WHERE name LIKE ?";
    params.push(search);
  } else if (limit) {
    query += " LIMIT ?";
    params.push(limit);
  }

  try {
    const rows = await db.all(query, params);
    
    res.status(200).json(rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const item = await db.get("SELECT * FROM menu WHERE id = ?", id);
    if (item) {
      res.status(200).json(item);
    } else {
      res.status(404).json({ message: "Item not found" });
    }
  } catch (err) {
    res.status(500).json({ message: err });
  }
});

router.post("/", userIsAdmin, async (req, res) => {
  const { name, category, description, img, price } = req.body;

  try {
    const { lastID } = await db.run(
      "INSERT INTO menu (name, category, description, img, price) VALUES (?, ?, ?, ?, ?)",
      [name, category, description, img, price]
    );
    const item = await db.get("SELECT * FROM menu WHERE id = ?", lastID);
    if (item){
      res.status(200).json(item);
    } else {
      res.status(500).send("Gagal menambahkan menu baru");
    }
  } catch (error) {
    res.status(500).send("Gagal menambahkan menu baru");
  }
});

router.delete("/:id", userIsAdmin, async (req, res) => {
  const menuId = req.params.id;

  try {
    await db.run("DELETE FROM menu WHERE id = ?", menuId);
    res.status(200).send(`Menu dengan ID ${menuId} berhasil dihapus`);
  } catch (error) {
    console.error(error.message);
    res.status(500).send("Gagal menghapus menu");
  }
});

router.put("/:id", userIsAdmin, async (req, res) => {
  const menuId = req.params.id;
  const { name, category, description, img, price } = req.body;
  try {
    // Mendapatkan data menu sebelumnya
    const existingMenu = await db.get(
      "SELECT * FROM menu WHERE id = ?",
      menuId
    );

    const updatedName = name || existingMenu.name;
    const updatedCategory = category || existingMenu.category;
    const updatedDescription = description || existingMenu.description;
    const updatedImg = img || existingMenu.img;
    const updatedPrice = price || existingMenu.price;

    console.log([
      updatedName,
      updatedCategory,
      updatedDescription,
      updatedImg,
      updatedPrice,
      menuId,
    ]);

    await db.run(
      "UPDATE menu SET name = ?, category = ?, description = ?, img = ?, price = ? WHERE id = ?",
      [
        updatedName,
        updatedCategory,
        updatedDescription,
        updatedImg,
        updatedPrice,
        menuId,
      ]
    );

    res.status(200).send("Menu berhasil diperbarui");
  } catch (error) {
    res.status(500).send("Gagal memperbarui menu");
  }
});

module.exports = router;
