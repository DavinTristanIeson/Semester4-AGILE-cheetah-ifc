const express = require("express");
const app = express();

const session = require("express-session");
const cors = require("cors");
const SQLiteStore = require("connect-sqlite3")(session);

const AccountsRouter = require("./api/account");
const MenuRouter = require("./api/menu");
const OrdersRouter = require("./api/orders");

const PORT = 3000;
const WHITELISTED_SOURCE = "http://localhost:5173";

app.use(
  cors({
    origin: WHITELISTED_SOURCE,
    credentials: true,
  })
);
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
app.use(sessionMiddleware);

app.use("/api/accounts", AccountsRouter);
app.use("/api/menu", MenuRouter);
app.use("/api/orders", OrdersRouter);

app.use((err, req, res, next) => {
  console.log(err.stack);
  if (!res.headersSent) {
    res.status(500).json({
      message:
        "Terjadi kesalahan di bagian server, mohon dicoba lagi pada waktu lain",
    });
  }
});

app.listen(PORT, async () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
