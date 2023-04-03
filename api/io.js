const { Server } = require("socket.io");
let io;

function dispatch(fn) {
  fn(io);
}

function initialize(httpServer, options, sessionMiddleware) {
  io = new Server(httpServer, options);

  const wrap = (middleware) => (socket, next) =>
    middleware(socket.request, {}, next);
  io.use(wrap(sessionMiddleware));
  io.use((socket, next) => {
    if (socket.request.session.user) next();
    else next(new Error("Unauthorized user"));
  });

  io.on("connection", (socket) => {
    const { isAdmin } = socket.request.session.user;
    if (isAdmin) socket.join("admin");
    else socket.join("customer");
    socket.on("disconnect", () => {
      socket.leave("customer");
      socket.leave("admin");
    });
  });
}

module.exports = { initialize, dispatch };
