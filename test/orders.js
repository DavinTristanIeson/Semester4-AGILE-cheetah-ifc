const agent = require("./setup");
const { expect } = require("chai");

async function makeOrder(menus){
    const res = await agent.post("/api/orders")
        .send(menus.map(x => ({...x, quantity: 1, note: ''})));
    expect(res).to.have.status(200);
    expect(res.body.status).to.equal(2);
    expect(res.body.records).to.have.lengthOf(menus.length);
    return res;
}

async function hasOngoing(){
    const res = await agent.get("/api/orders/ongoing");
    expect(res).to.have.status(200);
    return res;
}
async function noOngoing(){
    const res = await agent.get("/api/orders/ongoing");
    expect(res).to.have.status(404);
    return res;
}

module.exports = {
    makeOrder, hasOngoing, noOngoing
}