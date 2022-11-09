const NFTCollection = artifacts.require("NFTCollection");

module.exports = async (deployer, network) => {
  if (network === "ropsten" || network === "development") {
    return await deployer.deploy(NFTCollection); // deploy NFTCollection
  } else {
    return;
  }
};
