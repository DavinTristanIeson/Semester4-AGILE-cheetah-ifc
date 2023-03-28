const express = require("express");
const router = express.Router();
const db = require("./db.js");

router.get("/", async (req, res) => {
  const { search, limit, page } = req.query;
  let query = "SELECT * FROM menu";
  let params = [];
  if (search) {
    query += " WHERE name LIKE ?";
    params.push(`${search}%`);
  }
  if (page) {
    query += " WHERE name LIKE ?";
    params.push(limit, page * limit);
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

module.exports = router;
