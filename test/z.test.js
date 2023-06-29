const { ACCOUNT } = require("./login");
const agent = require("./setup");
const { expect } = require("chai");

// Cleanup
describe("Cleanup", () => {
    it("Delete User", async () => {
        const res = await agent.delete("/api/accounts").send({ password: ACCOUNT.password });
        expect(res).to.have.status(200);
    });
});