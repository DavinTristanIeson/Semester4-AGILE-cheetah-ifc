const express = require("express");
const router = express.Router();
const db = require("./db.js");

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
    
    if (params.length == 0){
      // Cache for three days if fetch all menu
      // https://stackoverflow.com/questions/25462717/cache-control-for-dynamic-data-express-js
      res.set("Cache-Control", `public, max-age=${3*24*60*1000}`)
    }
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
