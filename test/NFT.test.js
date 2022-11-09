const NFTCollection = artifacts.require("./contracts/NFTCollection.sol");
const Web3 = require("web3");

contract("NFTCollection", (accounts) => {
  let web3 = new Web3();
  let contract;
  let owner = accounts[0];

  beforeEach(async () => {
    contract = await NFTCollection.deployed();
  });

  it("Should have an address for contract", () => {
    assert(contract.address);
  });

  it("Stake token from last user", async () => {
    let tokenId = 4
    let data = await contract.getOptcode(tokenId);
    console.log(data.toString());
  });
});
