// our custom network configuration

const networkConfig = {
    // we can configure our priceFeedAddress according to chainId so we can use it seemlesly in our code
    // configuration for goerli (chainId 5)
    5: {
        name: "goerli",
        priceFeedAddress: "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e",
    },
    // configuration for sepolia (chainId 11155111)
    11155111: {
        name: "sepolia",
        priceFeedAddress: "0x694AA1769357215DE4FAC081bf1f309aDC325306",
    },
};

module.exports = {
    networkConfig,
};
