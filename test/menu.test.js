const { describe, it, after, before } = require("mocha");
const chai = require('chai');
const chaiHttp = require('chai-http');
chai.use(chaiHttp);
const { expect } = chai;
const agent = require("./setup.js");
const { loginAdmin, login } = require("./login.js");

describe("Feature: Get Menu", () => {
    const ENDPOINT = "/api/menu";
    it("Task: Get Menu", async () => {
        const res = await agent.get(ENDPOINT);
        expect(res).to.have.status(200);
        expect(res.body.data).to.have.lengthOf(25);
        expect(res.body.data[0]).to.haveOwnProperty("category");
        expect(res.body.data[0]).to.haveOwnProperty("id");
        expect(res.body.data[0]).to.haveOwnProperty("price");
    });
    it("Task: Get Paginated Menu", async () => {
        const pageNone = await agent.get(ENDPOINT);
        const pageOne = await agent.get(ENDPOINT).query({page: 1});
        const pageZero = await agent.get(ENDPOINT).query({page: 0});
        // page: 0 is default
        expect(pageNone.body.data.every((x, i) => x.id == pageZero.body.data[i].id)).to.be.true;
        // No intersection between different pages
        expect(pageZero.body.data.some((x, i) => x.id == pageOne.body.data[i].id)).to.be.false;
    });
    it("Task: Get Categories", async () => {
        const res = await agent.get(`${ENDPOINT}/categories`);
        // All are distinct
        expect(res.body).to.have.lengthOf(new Set(res.body).size);
    });
});

describe("Feature: Edit Menu", () => {
    let target;
    let ENDPOINT;
    before(async () => {
        await loginAdmin();
        const res = await agent.get("/api/menu");
        expect(res).to.have.status(200);
        target = res.body.data[0];
        ENDPOINT = `/api/menu/${target.id}`;
    });
    const MENU = {
        name: "Menu Saya",
        category: "Kategori Spesial",
        description: "Deskripsi",
        img: "https://valid-link.com",
        price: 20000,
    };
    it("Failure: Not Found", async () => {
        const res = await agent.put("/api/menu/sdgds");
        expect(res).to.have.status(404);
    });
    it("Task: Edit None", async () => {
        const res = await agent.put(ENDPOINT);
        expect(res).to.have.status(200);
    });
    it("Task: Edit Partial", async () => {
        const res = await agent.put(ENDPOINT).send({
            name: MENU.name,
            description: MENU.description,
            category: MENU.category,
        });
        expect(res.body.name).to.be.equal(MENU.name);
        expect(res.body.description).to.be.equal(MENU.description);
        expect(res.body.price).to.be.equal(target.price);
        
        const categoryRes = await agent.get("/api/menu/categories");
        expect(categoryRes).to.have.status(200);
        expect(categoryRes.body).to.include(MENU.category);
    });
    it("Task: Edit Price", async () => {
        let res = await agent.put(ENDPOINT).send({price: -1});
        expect(res).to.have.status(400);
        res = await agent.put(ENDPOINT).send({price: MENU.price});
        expect(res).to.have.status(200);
        expect(res.body.price).to.equal(MENU.price);
    });
    it("Task: Edit Img", async () => {
        let res = await agent.put(ENDPOINT).send({ img: "dsgsgsg" });
        expect(res).to.have.status(400);
        res = await agent.put(ENDPOINT).send({ img: "javascript:alert(0)" });
        expect(res).to.have.status(400);
        res = await agent.put(ENDPOINT).send({ img: MENU.img });
    });
});

describe("Feature: Delete Menu", () => {
    let target;
    let ENDPOINT;
    before(async () => {
        await loginAdmin();
        const res = await agent.get("/api/menu");
        expect(res).to.have.status(200);
        target = res.body.data[0];
        ENDPOINT = `/api/menu/${target.id}`;
    });
    it("Task: Delete Menu", async () => {
        let res = await agent.get(ENDPOINT);
        expect(res).to.have.status(200);
        res = await agent.delete(ENDPOINT);
        expect(res).to.have.status(200);
        res = await agent.get(ENDPOINT);
        expect(res).to.have.status(404);
    });
    after(login);
});