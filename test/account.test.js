const { describe, it, after } = require("mocha");
const chai = require('chai');
const chaiHttp = require('chai-http');
chai.use(chaiHttp);
const { expect } = chai;
const agent = require("./setup.js");
const { ACCOUNT, login, register } = require("./login.js");

describe("Feature: Register", () => {
    const ENDPOINT = "/api/accounts/register";
    it("Failure: Missing Fields", async () => {
        const { telp, ...rest } = ACCOUNT;
        const res = await agent
            .post(ENDPOINT)
            .send(rest);
        expect(res).to.have.status(400);
    });
    it("Failure: Null values", async () => {
        const payload = {...ACCOUNT};
        payload.name = null;
        const res = await agent
            .post(ENDPOINT)
            .send(payload);
        expect(res).to.have.status(400);
    });
    it("Failure: Improper Email Format", async () => {
        const payload = {...ACCOUNT};
        payload.email = "akun@email";
        const res = await agent
            .post(ENDPOINT)
            .send(payload);
        expect(res).to.have.status(400);
    });
    it("Failure: Improper Password", async () => {
        const payload = {...ACCOUNT};
        payload.password = "abcde";
        const res = await agent
            .post(ENDPOINT)
            .send(payload);
        expect(res).to.have.status(400);
    });
    it("Failure: Improper Name", async () => {
        const payload = {...ACCOUNT};
        payload.name = "冰淇淋";
        const res = await agent
            .post(ENDPOINT)
            .send(payload);
        expect(res).to.have.status(400);
    });
    it("Failure: Null Gender", async () => {
        const payload = {...ACCOUNT};
        payload.gender = null;
        const res = await agent
            .post(ENDPOINT)
            .send(payload);
        expect(res).to.have.status(400);
    });
    it("Failure: Invalid Telp", async () => {
        const payload = {...ACCOUNT};
        payload.telp = "abcdefghijk"
        const res = await agent
            .post(ENDPOINT)
            .send(payload);
        expect(res).to.have.status(400);
    });
    it("Success: Register", async () => {
        const res = await agent
            .post(ENDPOINT)
            .send(ACCOUNT);
        expect(res).to.have.status(201);
    });
    it("Failure: Duplicate email", async () => {
        const res = await agent
            .post(ENDPOINT)
            .send(ACCOUNT);
        expect(res.body.message).to.include("Email")
        expect(res).to.have.status(400);
    });
});

describe("Feature: Login", () => {
    const ENDPOINT = "/api/accounts/login";
    it("Failure: Wrong email or password", async () => {
        let res = await agent
            .post(ENDPOINT)
            .send({
                email: "akun@gmail.com",
                password: "akungmail"
            });
        expect(res).to.have.status(401);
        res = await agent
        .post(ENDPOINT)
        .send({
            email: "akun@email.com",
            password: "akungmail"
        });
        expect(res).to.have.status(401);
    });
    it("Failure: No email/password", async () => {
        const res = await agent
            .post(ENDPOINT)
            .send({});
        expect(res).to.have.status(400);
    });
    it("Success: Login", async () => {
        const res = await agent
            .post(ENDPOINT)
            .send({
                email: ACCOUNT.email,
                password: ACCOUNT.password,
            });
        expect(res).to.have.status(200);
        expect(res.body.email).to.equal(ACCOUNT.email);
        expect(res.body).to.haveOwnProperty("id");
    })
});

describe("Feature: Get Self Information", () => {
    it("Task: Get Authentication State", async () => {
        const res = await agent.get("/api/accounts/me");
        expect(res).to.have.status(200);
    });
    it("Task: Get Account Info", async () => {
        const res = await agent.get("/api/accounts");
        expect(res).to.have.status(200);
        expect(res.body.gender).to.equal(1);
        expect(res.body.isAdmin).to.equal(false);
        expect(res.body.name).to.equal(ACCOUNT.name);
    });
    it("Failure: Not Authenticated", async () => {
        let res = await chai.request("http://localhost:3000").get("/api/accounts/me");
        expect(res).to.have.status(401);
        res = await chai.request("http://localhost:3000").get("/api/accounts");
        expect(res).to.have.status(401);
    });
});

describe("Feature: Edit Account Information", async () => {
    const source = {
        email: "akun@gmail.com",
        password: "password1",
        name: "My Account",
        telp: "08512521215",
        gender: true,
    };
    const ENDPOINT = "/api/accounts";
    it("Task: Edit Account With No Payload", async () => {
        const res = await agent.put(ENDPOINT).send("");
        expect(res).to.have.status(200);
    });
    it("Failure: Invalid email format", async () => {
        const res = await agent.put(ENDPOINT).send({email: "email"});
        expect(res).to.have.status(400);
    });
    it("Task: Edit Partial", async () => {
        const res = await agent.put(ENDPOINT).send({name: source.name, telp: source.telp});
        expect(res).to.have.status(200);
        expect(res.body.telp).to.equal(source.telp);
        expect(res.body.name).to.equal(source.name);
        expect(res.body.email).to.equal("akun@email.com");
    });
    it("Task: Edit Everything Except Password", async () => {
        const { password, ...rest } = source;
        const res = await agent.put(ENDPOINT).send(rest);
        expect(res).to.have.status(200);
        expect(res.body.email).to.equal(source.email);
    });
    it("Failure: Edit Password Without Verification", async () => {
        const res = await agent.put(ENDPOINT).send({password: source.password});
        expect(res).to.have.status(400);
    });
    it("Failure: Edit Password With Wrong Verification", async () => {
        const res = await agent.put(ENDPOINT).send({password: source.password, verify: source.password});
        expect(res).to.have.status(401);
    });
    it("Task: Edit Password", async () => {
        const res = await agent.put(ENDPOINT).send({password: source.password, verify: "akunemail"});
        expect(res).to.have.status(200);
    });
    after(async () => {
        const res = await agent.put(ENDPOINT).send({...ACCOUNT, verify: "password1"});
        expect(res).to.have.status(200);
    });
});

describe("Feature: Delete Account Information", async () => {
    it("Task: Logout", async () => {
        let res = await agent.post("/api/accounts/logout");
        expect(res).to.have.status(200);
        res = await chai.request("http://localhost:3000").post("/api/accounts/logout");
        expect(res).to.have.status(400);

        // Log back in
        await login();
    });
    it("Failure: Logout when no session", async () => {
        let res = await chai.request("http://localhost:3000").post("/api/accounts/logout");
        expect(res).to.have.status(400);
    });
    it("Failure: No password", async () => {
        const res = await agent.delete("/api/accounts");
        expect(res).to.have.status(400);
    });
    it("Failure: Wrong password", async () => {
        const res = await agent.delete("/api/accounts").send({
            password: "akungmail"
        });
        expect(res).to.have.status(401);
    });
    it("Success: Goodbye Account", async () => {
        const res = await agent.delete("/api/accounts").send({
            password: "akunemail"
        });
        expect(res).to.have.status(200);
    });
    it("Failure: No more account", async () => {
        let res = await agent.get("/api/accounts");
        expect(res).to.have.status(401);
        res = await agent.post("/api/accounts/login").send({
            email: ACCOUNT.email,
            password: ACCOUNT.password,
        });
        expect(res).to.have.status(401);
    });
    after(register);
});