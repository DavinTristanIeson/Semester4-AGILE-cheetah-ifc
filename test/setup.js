const chai = require('chai');
const chaiHttp = require('chai-http');
chai.use(chaiHttp);
const agent = chai.request.agent("http://localhost:3000");
module.exports = agent;