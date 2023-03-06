const deployFunc = async (hre) => {
    const { getNamedAccounts, deployments } = hre;

    // console.log(await getNamedAccounts());

    const { deploy, log } = deployments;
    const { deployer } = await getNamedAccounts();
    const chainId = hre.network.config.chainId;

    console.log("yohohoho");

    // when going for localhost or hardhat network we want to use a mock
    // a mock simulates a real object. In short mocks are fake objects having properties of real objects
    // In our contract we need contract address for ETH/USD mapping which is different from chain to chain
    // and is not available to use or test locally (local network or hardhat network).

    // we also do not want to change our solidity code chaning our contract address when we want to change the chain

    // const priceFeedAddress = "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e";
    // we can use following syntax to add different priceFeedAddresses according the network selected
    // if chaindId is X use address Y
    // if chaindId is Z use address A
    // but we are going to create a custom network configuration in this case in helper-hardhat-config.js (inspiration from aave-v3-core github repo)

    const fundMe = await deploy("FundMe", {
        from: deployer,
        // we can pass arguments to contract construtor here
        args: [],
        log: true,
    });
};

module.exports.default = deployFunc;
