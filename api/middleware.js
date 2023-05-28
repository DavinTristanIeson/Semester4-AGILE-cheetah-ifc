module.exports = {
  userIsCustomer(req, res, next) {
    if (req.session.user) next();
    else res.status(401).end();
  },
  userIsAdmin(req, res, next) {
    if (req.session.user && req.session.user.isAdmin) next();
    else res.status(401).end();
  },
  paginate(data, limit){
    if (data.length == 0) return {pages: 0, data: []};
    let total = data[0]._total;
    return {
      pages: Math.ceil(total / limit),
      data: data.map(x => {
        delete x._total;
        return x;
      })
    };
  },
  getPaginationQuery(statement){
    return `SELECT * FROM (SELECT COUNT(*) OVER() AS _total, ${statement}) LIMIT ? OFFSET ?`;
  }
};
