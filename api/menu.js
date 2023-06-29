const express = require("express");
const router = express.Router();
const db = require("./db.js");
const { userIsAdmin, getPaginationQuery, paginate } = require("./middleware");

router.get("/categories", async (req, res, next) => {
  try {
    const categories = await db.all("SELECT DISTINCT category FROM menu");
    res.setHeader("Cache-Control", `max-age=${24*60*60*1000}`);
    res.status(200).json(categories.map(x => x.category));
  } catch (e) {
    next(e);
  }
});

const MENU_LIMIT = 25;
router.get("", async (req, res, next) => {
  const { search, page: rawPage, category } = req.query;

  let page = rawPage ? parseInt(rawPage) : 0;
  if (isNaN(page)){
    res.status(400).json({message: "Page harus merupakan angka"});
    return;
  }

  let params = [];
  let query = "* FROM menu";
  if (search) {
    query += " WHERE name LIKE ?";
    params.push(`%${search}%`);
  }
  if (category){
    const condition = "category = ?"
    query += `${params.length > 0 ? ' AND ' : ' WHERE '}${condition}`;
    params.push(category);
  }
  params.push(MENU_LIMIT, page * MENU_LIMIT);

  try {
    const rows = await db.all(getPaginationQuery(query), params);
    
    res.status(200).json(paginate(rows, MENU_LIMIT));
  } catch (err) {
    next(err);
  }
});

router.get("/:id", async (req, res, next) => {
  const { id } = req.params;
  try {
    const item = await db.get("SELECT * FROM menu WHERE id = ?", id);
    if (item) {
      res.status(200).json(item);
    } else {
      res.status(404).json({ message: "Item not found" });
    }
  } catch (err) {
    next(err);
  }
});

router.post("", userIsAdmin, async (req, res, next) => {
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
    next(error);
  }
});

router.delete("/:id", userIsAdmin, async (req, res, next) => {
  const menuId = req.params.id;

  try {
    await db.run("DELETE FROM menu WHERE id = ?", menuId);
    res.status(200).send(`Menu dengan ID ${menuId} berhasil dihapus`);
  } catch (error) {
    next(error);
  }
});

router.put("/:id", userIsAdmin, async (req, res, next) => {
  const menuId = req.params.id;
  const { name, category, description, img, price } = req.body;
  try {
    // Mendapatkan data menu sebelumnya
    const existingMenu = await db.get(
      "SELECT * FROM menu WHERE id = ?",
      menuId
    );

    if (!existingMenu){
      res.status(404).json({message: "Tidak dapat menemukan item menu dengan ID " + menuId});
      return;
    }

    if (img){
      let url;
      try {
        url = new URL(rawURL);
      } catch (e){
        res.status(400).json({message: "Bukan URL valid"});
        return;
      }
      if (
        (url.protocol != "http:" && url.protocol != "https:") ||
        (url.username.length > 0 || url.password.length > 0)
      ){
        res.status(400).json({
          message: "Bukan URL gambar valid. URL harus dimulai dengan protokol http atau https"
        });
        return;
      }
    }

    if (price && price <= 0){
      res.status(400).json({
        message: "Harga tidak boleh dibawah 1"
      });
      return;
    }

    const updatedName = name || existingMenu.name;
    const updatedCategory = category || existingMenu.category;
    const updatedDescription = description || existingMenu.description;
    const updatedImg = img || existingMenu.img;
    const updatedPrice = price || existingMenu.price;

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
    const menu = await db.get("SELECT * FROM menu WHERE id = ?", [existingMenu.id]);
    res.status(200).json(menu);
  } catch (error) {
    next(error);
  }
});

module.exports = router;
