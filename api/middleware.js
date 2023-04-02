module.exports = {
  userIsCustomer(req, res, next) {
    if (req.session.user) next();
    else res.status(401).end();
  },
  userIsAdmin(req, res, next) {
    if (req.session.user && req.session.user.isAdmin) next();
    else res.status(401).end();
  },
};
