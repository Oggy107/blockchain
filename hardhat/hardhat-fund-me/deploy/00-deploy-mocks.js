const deployMock = async ({ getNamedAccounts, deployments, network }) => {
    const { deploy, log } = deployments;
    const { deployer } = await getNamedAccounts();
    const chainId = network.config.chainId;

    // we do not want to deploy this mock to a testnet or network where priceFeed contract is already available
    // so we are going to restrict the deployment to localnetworks

    if (chainId != 11155111 || chainId != 5) {
        log("Local network detected! Deploying mocks...");
        await deploy("MockV3Aggregator", {
            from: deployer,
            // we can find mock constructor parameters in source code
            log: true,
        });
    }
};

module.exports.default = deployMock;
