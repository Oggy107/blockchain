require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-gas-reporter");
// solidity-coverage plugin shows the number of lines of solidity source code covered in tests. so you can be sure that you are testing everyting in your contract
require("solidity-coverage");
require("dotenv").config();

const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;

// creating as hardhat task
task("brook", "summons brook").setAction(async () => {
    console.log("Robin san may I see your panties. Yohohohohoho");
});

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.18",
    defaultNetwork: "hardhat",
    networks: {
        // we need to add networks here to be able to use them in hardhat --network option
        // due to this we do not need to add rpc url and keys in our code
        goerli: {
            url: GOERLI_RPC_URL,
            accounts: [PRIVATE_KEY],
            chainId: 5,
        },
        // we can spin up local HTTP JSON-RPC server using hardhat node task and use it using --network option
        // note: default hardhat network is different from this locally running network though it has same chainid as hardhat network
        local: {
            url: "http://127.0.0.1:8545/",
            // we do not need to pass accounts in here as hardhat will place them automatically
            accounts: [
                "0xdf57089febbacf7ba0bc227dafbffa9fc08a93fdc68e1e42411a14efcf23656e",
            ],
            chainId: 31337,
        },
        // we can also add ganache local netork here and interact with it in code and using hardhat console
        ganache: {
            url: "http://127.0.0.1:7545",
            accounts: [
                "63329e97c01c9e286bf6954f13b4b7403ab872a12d380a181f9e9627a308292c",
            ],
            chainId: 1337,
        },
    },
    // hardhat etherscan plugin
    // you can get this api key at etherscans official website
    etherscan: {
        apiKey: ETHERSCAN_API_KEY,
    },
    // hardhat-gas-reporter plugin configuration. we can install it using npm or yarn
    gasReporter: {
        enabled: true,
        // optional
        outputFile: "gas-report.txt",
        noColors: true,
        // we need to add CoinMarketCap api key to get price in USD
        // currency: "USD",
        // coinmarketcap: {api key here}
        // add token and gasPriceApi to retrieve the gas price of a particular blockchain
    },
};
