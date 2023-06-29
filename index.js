const express = require("express");
const app = express();

const session = require("express-session");
const cors = require("cors");
const SQLiteStore = require("connect-sqlite3")(session);
const path = require("path");
const fs = require("fs");

const AccountsRouter = require("./api/account");
const MenuRouter = require("./api/menu");
const OrdersRouter = require("./api/orders");
const { initialize } = require("./api/io");

const PORT = 3000;
const WHITELISTED_SOURCE = "http://localhost:3000";

const IS_TEST_MODE = process.argv.includes("--test");

app.use(
  cors({
    origin: WHITELISTED_SOURCE,
    credentials: true,
  })
);
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


if (IS_TEST_MODE && fs.existsSync("./test-sessions.db")){
  fs.rmSync("./test-sessions.db");
}
const sessionMiddleware = session({
  store: new SQLiteStore({db: IS_TEST_MODE ? 'test-sessions.db' : 'sessions.db'}),
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
app.use(sessionMiddleware);

app.use("/api/accounts", AccountsRouter);
app.use("/api/menu", MenuRouter);
app.use("/api/orders", OrdersRouter);

app.get("/admin/:route?", (req, res, next)=>{
  if (!req.params.route || ["ongoing", "transactions", "login"].includes(req.params.route)){
    res.sendFile("./frontend/dist/admin.html", {root: __dirname});
  } else next();
});
app.get("/:route?", (req, res, next)=>{
  if (!req.params.route || ["order", "account", "history"].includes(req.params.route)){
    res.sendFile("./frontend/dist/index.html", {root: __dirname});
  } else next();
});
app.use(express.static(path.join(__dirname, "/frontend/dist")));

app.use((err, req, res, next) => {
  console.log(err.stack);
  if (!res.headersSent) {
    res.status(500).json({
      message:
        "Terjadi kesalahan di bagian server, mohon dicoba lagi pada waktu lain",
    });
  }
});

const server = app.listen(PORT, async () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
initialize(
  server,
  { cors: WHITELISTED_SOURCE, credentials: true },
  sessionMiddleware
);