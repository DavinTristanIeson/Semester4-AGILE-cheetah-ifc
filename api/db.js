const { SQLitePromise } = require("./SQLitePromise");
const fs = require("fs");
const MENU = require("./free-food-menus-api.json");

async function loadMenu(db) {
  await db.run(`CREATE TABLE IF NOT EXISTS menu (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		name TEXT NOT NULL,
		category TEXT,
		description TEXT DEFAULT "",
		img TEXT DEFAULT "",
		price INT NOT NULL
	)`);
  if (await db.get(`SELECT * FROM menu`)) return;

  const stmt = db.prepare(
    `INSERT INTO menu (name, category, description, img, price) VALUES (?, ?, ?, ?, ?)`
  );
  for (let category in MENU) {
    if (category == "pagination") continue;
    await Promise.all(
      MENU[category].map((x) =>
        stmt.run([
          x.name,
          category,
          x.dsc,
          x.img,
          Math.round((x.price / 100) * 15000),
        ])
      )
    );
  }
  await stmt.finalize();
}

async function main(db) {
  await db.run("PRAGMA foreign_keys = ON");
  await db.run(
    "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT UNIQUE NOT NULL, password TEXT NOT NULL, name TEXT NOT NULL, gender INTEGER NOT NULL, telp TEXT NOT NULL, isAdmin INT DEFAULT 0)"
  );
  await db.run(
    "CREATE TABLE IF NOT EXISTS orders (id INTEGER PRIMARY KEY AUTOINCREMENT, account_id INT, order_time TEXT NOT NULL, status INT DEFAULT 0, FOREIGN KEY (account_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE SET NULL)"
  );
  await db.run(
    "CREATE TABLE IF NOT EXISTS orders_records (id INTEGER PRIMARY KEY AUTOINCREMENT, order_id INT NOT NULL, name TEXT NOT NULL, price INT NOT NULL, quantity INT NOT NULL, note TEXT, FOREIGN KEY (order_id) REFERENCES orders ON UPDATE CASCADE ON DELETE CASCADE)"
  );

  await loadMenu(db);
}

const IS_TEST_MODE = process.argv.includes("--test");
if (IS_TEST_MODE && fs.existsSync("./test-backend.db")){
  fs.rmSync("./test-backend.db");
}
const db = new SQLitePromise(IS_TEST_MODE ? "./test-backend.db" : "./backend.db");
main(db);

module.exports = db;
