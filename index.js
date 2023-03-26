const express = require("express");
const app = express();

const session = require("express-session");
const cors = require("cors");
const SQLiteStore = require("connect-sqlite3")(session);

const AccountsRouter = require("./api/account");

const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const sessionMiddleware = session({
  store: new SQLiteStore(),
  secret: "yoursecretkey",
  resave: false,
  saveUninitialized: false,
  cookie: {
    maxAge: 24 * 3600 * 1000,
    secure: false,
    path: "/",
    sameSite: "lax",
    httpOnly: true,
  },
});
app.use(sessionMiddleware());
app.use("/api/accounts", AccountsRouter);

app.listen(PORT, async () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
