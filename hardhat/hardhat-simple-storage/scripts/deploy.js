// import ethers from hardhat wrapped ethers so that hardhat can keep track of contracts and other stuff
const { ethers } = require("hardhat");

const main = async () => {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    );

    // by default deployment is done on the local hardhat network which comes prebuilt in hardhat, it works like ganache
    // we do not have to manually add private keys and rpc url to connect with local network provider like ganache
    console.log("Deploying contact...");
    const simpleStorage = await SimpleStorageFactory.deploy();
    await simpleStorage.deployed();
};

main()
    .then(() => {
        process.exit(0);
    })
    .catch((err) => {
        console.error(err);
        process.exit(1);
    });
