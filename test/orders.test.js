const { describe, it, after, before } = require("mocha");
const chai = require('chai');
const chaiHttp = require('chai-http');
chai.use(chaiHttp);
const { expect } = chai;
const agent = require("./setup.js");
const { loginAdmin, login } = require("./login.js");
const e = require("express");
const { hasOngoing, makeOrder, noOngoing } = require("./orders.js");

let menus;
describe("Feature: Make an order", () => {
    const ENDPOINT = "/api/orders";
    before(async () => {
        const res = await agent.get("/api/menu");
        expect(res).to.have.status(200);
        menus = res.body.data.slice(0, 4);
    });
    it("Failure: No Order or not an array", async () => {
        let res = await agent.post(ENDPOINT)
            .send([]);
        expect(res).to.have.status(400);
        res = await agent.post(ENDPOINT)
            .send({ hello: "world" });
        expect(res).to.have.status(400);
    });
    it("Failure: Imperfect Menu Item", async () => {
        const res = await agent.post(ENDPOINT)
            .send(menus.map(x => {
                const { name, ...rest } = x;
                return rest;
            }));
        expect(res).to.have.status(400);
    });
    it("Task: Make an Order", async () => {
        // Check no order yet
        const orderRes = await agent.get("/api/orders/ongoing");
        expect(orderRes).to.have.status(404);

        // Make an order
        await makeOrder(menus);
    });
    it("Task: Get Ongoing Order", async () => {
        await hasOngoing();
    });
});

describe("Feature: Change Status", () => {
    let order, ENDPOINT;
    before(async () => {
        order = await hasOngoing();
        ENDPOINT = `/api/orders/${order.body.id}/status`;
    });
    it("Failure: Invalid Status", async () => {
        await loginAdmin();
        const res = await agent.put(ENDPOINT).send({status: "hello"});
        expect(res).to.have.status(400);
    });
    it("Task: Change Status", async () => {
        let res = await agent.put(ENDPOINT).send({status: 1});
        expect(res).to.have.status(200);
        await login();
        let ongoing = await hasOngoing();
        expect(ongoing).to.have.status(200);
        expect(ongoing.body.status).to.equal(1);

        await loginAdmin();
        res = await agent.put(ENDPOINT).send({status: 0});
        await login();
        await noOngoing();
    });
});

describe("Feature: Get History", () => {
    before(async () => {
        await login();
        let res = await makeOrder(menus);
        expect(res).to.have.status(200);

        await loginAdmin();
        const res2 = await agent.put(`/api/orders/${res.body.id}/status`).send({status: 1});
        expect(res2).to.have.status(200);
    });
    it("Task: Transactions Only Have Finished Orders", async () => {
        await login();
        let res = await agent.get("/api/orders/history");
        expect(res.body.data.every(x => x.status === 0)).to.be.true;
        await loginAdmin();
        res = await agent.get("/api/orders/transactions");
        expect(res.body.data.every(x => x.status === 0)).to.be.true;
    });
    it("Task: User cannot access transactions", async () => {
        await login();
        const res = await agent.get("/api/orders/transactions");
        expect(res).to.have.status(401);
    });
});