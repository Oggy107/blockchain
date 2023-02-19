// import ethers from hardhat wrapped ethers so that hardhat can keep track of contracts and other stuff
const hre = require("hardhat");
require("dotenv").config();

const ethers = hre.ethers;
const HARDHAT_CHAINID = hre.config.networks.hardhat.chainId;

const main = async () => {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    );

    // by default deployment is done on the local hardhat network which comes prebuilt in hardhat, it works like ganache
    // we do not have to manually add private keys and rpc url to connect with local network provider like ganache
    // but we need to add network (testnet or mainnet) in hardhat.config.js file to able to use it in hardhat --network option
    console.log("Deploying contact...");

    const simpleStorage = await SimpleStorageFactory.deploy();
    await simpleStorage.deployed();
    console.log(`Deployed contract to: ${simpleStorage.address}`);

    // we do not need to call verify if we are deploying contract over local hardhat network or if we dont have etherscan api key
    // hre.network.config contains info about current network
    console.log("current network: ", hre.network.config);
    if (
        process.env.ETHERSCAN_API_KEY &&
        hre.network.config.chainId != HARDHAT_CHAINID
    ) {
        // we need to wait for few block confirmation because etherscan might not know about transaction yet
        // waiting for 6 blocks
        await simpleStorage.deployTransaction.wait(6);
        // verify(simpleStorage.address);
        console.log("calling verify");
        simple;
    }

    // interacting with contract

    let currentNumber = await simpleStorage.getNumber();
    console.log(`Current Number: ${currentNumber}`);
    const transactionResponse = await simpleStorage.storeNumber(77);
    // waiting for 1 block confirmation
    await transactionResponse.wait(1);
    currentNumber = await simpleStorage.getNumber();
    console.log(`Number set to: ${currentNumber}`);
};

// verifing contract source code so that it can be viewed on ether blockexplorers
const verify = async (contractAddress, args = {}) => {
    // we can use the etherscan api purely in javascipt here to verify our contract source code
    // but hardhat provides a plugin named (nomiclabs/hardhat-etherscan) to make this process easy
    // https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan
    // this plugin provides verify task in hardhat that we can use to verify contracts through command line
    // but we can also do this in following way
    // we can also pass arguments if contract's constructor requires any

    const HARDHAT_TASK_VERIFY = "verify:verify";

    console.log("verifying contract...");
    // we can run any hardhat task in code using run method provided by hardhat environment
    // run will throw exception if contract is already verified
    try {
        await hre.run(HARDHAT_TASK_VERIFY, {
            address: contractAddress,
            constructorArguments: args,
        });
    } catch (error) {
        if (error.message.toLowerCase().includes("already verified")) {
            console.log("Alredy Verified!");
        } else {
            console.warn(error);
        }
    }
};

main()
    .then(() => {
        process.exit(0);
    })
    .catch((err) => {
        console.error(err);
        process.exit(1);
    });
