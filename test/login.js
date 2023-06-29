const agent = require("./setup.js");
const { expect } = require("chai");

const ACCOUNT = {
    email: "akun@email.com",
    password: "akunemail",
    name: "Akun Saya",
    telp: "08512521215",
    gender: true,
};
async function login(){
    const res = await agent.post("/api/accounts/login").send({
        email: ACCOUNT.email,
        password: ACCOUNT.password
    });
    expect(res).to.have.status(200);
    return res;
}
async function loginAdmin(){
    const res = await agent.post("/api/accounts/login/admin").send({
        password: "adminpass"
    });
    expect(res).to.have.status(200);
    return res;
}
async function register(){
    const res = await agent.post("/api/accounts/register").send(ACCOUNT);
    expect(res).to.have.status(201);
    return res;
}
module.exports = {
    ACCOUNT,
    login, register, loginAdmin
}