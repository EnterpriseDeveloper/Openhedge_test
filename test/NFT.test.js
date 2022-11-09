const NFTCollection = artifacts.require("./contracts/NFTCollection.sol");
const Web3 = require("web3");

contract("NFTCollection", (accounts) => {
  let web3 = new Web3();
  let contract;
  let owner = accounts[0];
  let testOne = "[29,29,9,36,9,66,3,29,66,9,24,16]";
  let testTwo = "[23,23,5,18,5,94,5,23,94,5,21,14]";
  let testThree = "[18,18,4,10,4,9,37,18,9,4,6,20]";

  beforeEach(async () => {
    contract = await NFTCollection.deployed();
  });

  it("Should have an address for contract", () => {
    assert(contract.address);
  });

  it("Deploy all NFT at once", async () => {
    await contract.createOpenhedgeNFT({ from: owner });
    let init = await contract.initialization();
    assert.equal(init.toString(), "true");
  });

  it("Get first otpcode", async () => {
    let tokenId = 25;
    let data = await contract.getOptcode(tokenId);
    assert.equal(data.toString(), testOne);
  });

  it("Get second otpcode", async () => {
    let tokenId = 30;
    let data = await contract.getOptcode(tokenId);
    assert.equal(data.toString(), testTwo);
  });

  it("Get third otpcode", async () => {
    let tokenId = 40;
    let data = await contract.getOptcode(tokenId);
    assert.equal(data.toString(), testThree);
  });
});
