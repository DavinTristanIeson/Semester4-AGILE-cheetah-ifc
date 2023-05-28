const express = require("express");
const router = express.Router();
const db = require("./db");
const { userIsAdmin, userIsCustomer } = require("./middleware");
const { dispatch } = require("./io");

function createOrdersArray(orders) {
  const collection = {};
  for (let order of orders) {
    if (!collection.hasOwnProperty(order.oid)) {
      collection[order.oid] = {
        id: order.oid,
        time: order.order_time,
        user: order.username,
        records: [],
        status: order.status,
      };
    }
    collection[order.oid].records.push({
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
  return {
    id: order[0].oid,
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
"SELECT \
orders.id as oid, \
orders.order_time, \
orders.status as status \
users.name as username, \
orders_records.id as record_id,\
orders_records.name as record_name, \
orders_records.price as record_price, \
orders_records.note as record_note, \
orders_records.quantity as record_quantity \
FROM orders \
JOIN orders_records \
ON orders.id = orders_records.order_id \
JOIN users \
ON orders.account_id = users.id";

function paginatedOrderQuery(condition){
  return `SELECT \
orders_records.id as record_id,\
orders_records.name as record_name, \
orders_records.price as record_price, \
orders_records.note as record_note, \
orders_records.quantity as record_quantity, \
* \
FROM (SELECT \
orders.id AS oid, \
orders.order_time, \
orders.status AS status, \
users.name AS username \
FROM orders \
JOIN users \
ON orders.account_id = users.id \
${condition} \
ORDER BY order_time DESC \
LIMIT ? OFFSET ?) \
JOIN orders_records \
ON oid = orders_records.order_id`;
}

const COUNT_QUERY = "SELECT COUNT(*) AS _total FROM orders";

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

    const raw = await db.all(ORDER_QUERY + " WHERE order_id = ?", [
      changed.lastID,
    ]);
    const order = createOrderObject(raw);
    if (!order) {
      res.status(404).end();
      return;
    }
    res.status(200).json(order);
    dispatch((io) => {
      io.to("admin").emit("newOrder", order);
    });
  } catch (err) {
    next(err);
  }
});

// semua orderan
router.get("/", userIsAdmin, async (req, res, next) => {
  try {
    let page = req.query.page || 1;
    const limit = 25;
    const offset = (page - 1) * limit;

    const { _total: count } = await db.get(COUNT_QUERY + " WHERE orders.status = ?", [0]);
    const orders = await db.all(
      paginatedOrderQuery("WHERE orders.status = ?"),
      [limit, offset]
    );

    res.status(200).json({
      pages: Math.ceil(count / limit),
      data: createOrdersArray(orders),
    });
  } catch (err) {
    next(err);
  }
});

// semua transaksi (YANG SUDAH SELESAI) dalam selang waktu tertentu
router.get("/transactions", userIsAdmin, async (req, res, next) => {
  let page = req.query.page || 1;
  const limit = 25;
  const offset = (page - 1) * limit;
  try {
    const { _total: count } = await db.get(COUNT_QUERY + " WHERE orders.status = ?", [0]);
    const orders = await db.all(
      paginatedOrderQuery("WHERE orders.status = ?"),
      [0, limit, offset]
    );
    res.status(200).json({
      pages: Math.ceil(count / limit),
      data: createOrdersArray(orders),
    });
  } catch (err) {
    next(err);
  }
});

// status spesifik order
router.get("/:orderId/status", userIsCustomer, async (req, res, next) => {
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
});

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

    if (status == 0) {
      dispatch((io) => {
        io.to("customer").emit("finishOrder", req.params.orderId);
      });
    } else if (status == 1) {
      dispatch((io) => {
        io.to("customer").emit("cookOrder", req.params.orderId);
      });
    }

    res.status(200).json({ message: "Order status updated successfully" });
  } catch (err) {
    next(err);
  }
});

router.get("/history", userIsCustomer, async (req, res, next) => {
  try {
    let page = req.query.page || 1;
    const limit = 25;
    const offset = (page - 1) * limit;

    const { _total: count } = await db.get(COUNT_QUERY + " WHERE account_id = ?", [req.session.user.id]);
    const orders = await db.all(
      paginatedOrderQuery("WHERE account_id = ? AND status = ?"),
      [req.session.user.id, 0, limit, offset] // 0 = finished status
    );

    res.status(200).json({
      pages: Math.ceil(count/limit),
      data: createOrdersArray(orders)
    });
  } catch (err) {
    next(err);
  }
});

router.get("/ongoing", userIsCustomer, async (req, res, next) => {
  try {
    const order = await db.all(
      ORDER_QUERY + " WHERE account_id = ? AND (status = 1 OR status = 2)",
      [req.session.user.id]
    );
    if (order.length == 0) res.status(404).end();
    else {
      const orderObj = createOrderObject(order);
      res.status(200).json(orderObj);
    }
  } catch (err) {
    next(err);
  }
});

router.get("/chef", userIsAdmin, async (req, res, next) => {
  try {
    const orders = await db.all(
      ORDER_QUERY +
        " WHERE orders.status = ? OR orders.status = ?",
      [1, 2] // 1 = pending status, 2 = cooking status
    );

    res.status(200).json(createOrdersArray(orders));
  } catch (err) {
    next(err);
  }
});

// Menghapus pesanan pelanggan dan mengirimkan notif ke customer
router.delete("/:id", userIsAdmin, async (req, res, next) => {
  const orderId = req.params.id;
  const { reason } = req.body;

  try {
    const order = await db.get("SELECT * FROM orders WHERE id = ?", orderId);
    if (!order) {
      res.status(404).json({ message: "Order not found" });
      return;
    }

    await db.run("DELETE FROM orders WHERE id = ?", orderId);
    await db.run("DELETE FROM orders_records WHERE order_id = ?", orderId);

    // Mengirim notifikasi ke pelanggan
    const message =
      reason || "Pesanan Anda dengan ID " + orderId + " telah dibatalkan oleh admin.";
    dispatch(io => io.to("customer").emit("cancelOrder", orderId, message));

    res.status(200).json({ message: "Order canceled" });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
