require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.18",
    defaultNetwork: "hardhat",
    networks: {
        local: {
            url: "http://127.0.0.1:8545/",
            chainId: 31337,
        },
        ganache: {
            url: "http://127.0.0.1:7545",
            // we can make it easy to work with multiple accounts with namedAccounts
            accounts: [
                "e21c9c8d5e502a7720b3d730638bf4f93fb94e7c682c2ce2164c7ca82e4c6a57",
                "d81818aac7b668bfc690e975d1b7e000f274957038572cab49f8219efec85fbb",
            ],
            chainId: 1337,
        },
        goerli: {
            url: "https://goerli.blockpi.network/v1/rpc/public",
            chainId: 5,
        },
        sepolia: {
            url: "https://rpc.sepolia.org",
            chainId: 11155111,
        },
    },
    // we can have namedAccounts to work with muliple accounts in our networks
    namedAccounts: {
        deployer: {
            // default specified default account index to use as deployer
            default: 0,
            // we can also specifiy deployer for each network (with chian id)
            // local network: second account
            // 31337: 1,
            // ganache network: second account
            // 1337: 1,
        },
        // we can create multiple namedAccounts as we like
        // for example
        user: {
            default: 1,
        },
    },
};
