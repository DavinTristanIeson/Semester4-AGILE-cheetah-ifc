const express = require("express");
const router = express.Router();
const db = require("./db");
const { userIsAdmin, userIsCustomer } = require("./middleware");

function createOrdersArray(orders) {
  const collection = {};
  for (let order of orders) {
    if (!collection.hasOwnProperty(order.order_id)) {
      collection[order.order_id] = {
        id: order.order_id,
        time: order.order_time,
        user: order.username,
        records: [],
        status: order.status,
      };
    }
    collection[order.order_id].records.push({
      id: order.record_id,
      name: order.record_name,
      price: order.record_price,
      quantity: order.record_quantity,
      note: order.record_note,
    });
  }
  return Object.values(collection);
}

function createOrderObject(order) {
  if (order.length == 0) return {};
  return {
    id: order[0].order_id,
    time: order[0].order_time,
    user: order[0].username,
    records: order.map((record) => {
      return {
        id: record.record_id,
        name: record.record_name,
        price: record.record_price,
        quantity: record.record_quantity,
        note: record.record_note,
      };
    }),
    status: order[0].status,
  };
}

const ORDER_QUERY =
  "SELECT orders.id as order_id, users.name as username, orders.order_time, orders_records.id as record_id,\
orders_records.name as record_name, orders_records.price as record_price, orders_records.note as record_note, orders_records.quantity as record_quantity, orders.status as status \
FROM orders JOIN orders_records ON orders.id = orders_records.order_id JOIN users ON orders.account_id = users.id";

router.post("/", userIsCustomer, async (req, res, next) => {
  try {
    const changed = await db.run(
      "INSERT INTO orders (account_id, order_time, status) VALUES (?, ?, 2)",
      [req.session.user.id, new Date().toISOString()]
    );
    const stmt = await db.prepare(
      "INSERT INTO orders_records (order_id, name, price, quantity, note) VALUES (?, ?, ?, ?, ?)"
    );
    for (let item of req.body) {
      await stmt.run([
        changed.lastID,
        item.name,
        item.price,
        item.quantity,
        item.note,
      ]);
    }
    await stmt.finalize();

    const order = createOrderObject(
      await db.all(ORDER_QUERY + " WHERE orders.id = ?", [changed.lastID])
    );
    res.status(200).json(order);
  } catch (err) {
    next(err);
  }
});

// semua orderan
router.get("/", userIsAdmin, async (req, res, next) => {
  try {
    let start = req.query.start || "1970-01-01T00:00:00.000Z";
    let end = req.query.end || new Date().toISOString();

    const orders = await db.all(
      ORDER_QUERY + " WHERE orders.order_time BETWEEN ? AND ?",
      [start, end]
    );

    const ordersArray = createOrdersArray(orders);
    res.status(200).json(ordersArray);
  } catch (err) {
    next(err);
  }
});

// semua transaksi (YANG SUDAH SELESAI) dalam selang waktu tertentu
router.get("/transactions", userIsAdmin, async (req, res, next) => {
  let start = req.query.start || "1970-01-01T00:00:00.000Z";
  let end = req.query.end || new Date().toISOString();
  try {
    const orders = await db.all(ORDER_QUERY + " WHERE (orders.order_time BETWEEN ? AND ?) AND orders.status = ?", [start, end, 0]);
    res.status(200).json(createOrdersArray(orders));
  } catch (err) {
    next(err);
  }
});

// status spesifik order
router.get(
  "/:orderId/status",
  userIsCustomer,
  async (req, res, next) => {
    try {
      const order = await db.get(
        "SELECT * FROM orders WHERE id = ? AND account_id = ?",
        [req.params.orderId, req.session.user.id]
      );

      if (!order) {
        res.status(404).json({ error: "Order not found" });
        return;
      }

      res.status(200).json({ status: order.status });
    } catch (err) {
      next(err);
    }
  }
);

// ganti mode untuk admin
router.put("/:orderId/status", userIsAdmin, async (req, res, next) => {
  const { status } = req.body;

  try {
    const order = await db.get("SELECT * FROM orders WHERE id = ?", [
      req.params.orderId,
    ]);

    if (!order) {
      res.status(404).json({ error: "Order not found" });
      return;
    }

    const allowedStatuses = [0, 1, 2];

    if (!allowedStatuses.includes(status)) {
      res.status(400).json({ error: "Invalid status" });
      return;
    }

    await db.run("UPDATE orders SET status = ? WHERE id = ?", [
      status,
      req.params.orderId,
    ]);

    res.status(200).json({ message: "Order status updated successfully" });
  } catch (err) {
    next(err);
  }
});

router.get("/history", userIsCustomer, async (req, res, next) => {
  try {
    const orders = await db.all(
      ORDER_QUERY + " WHERE account_id = ? AND status = ?",
      [req.session.user.id, 0] // 0 = finished status
    );
    res.status(200).json(createOrdersArray(orders));
  } catch (err) {
    next(err);
  }
});

router.get("/chef", userIsAdmin, async (req, res, next) => {
  try {
    let start = req.query.start || "1970-01-01T00:00:00.000Z";
    let end = req.query.end || new Date().toISOString();

    const orders = await db.all(
      ORDER_QUERY +
        " WHERE orders.order_time BETWEEN ? AND ? AND (orders.status = ? OR orders.status = ?)",
      [start, end, 1, 2] // 1 = pending status, 2 = cooking status
    );
    res.json(createOrdersArray(orders));
  } catch (err) {
    next(err);
  }
});

module.exports = router;
