const express = require("express");
const app = express();

const session = require("express-session");
const cors = require("cors");
const SQLiteStore = require("connect-sqlite3")(session);

const PORT = 3000;

app.listen(PORT, async () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
