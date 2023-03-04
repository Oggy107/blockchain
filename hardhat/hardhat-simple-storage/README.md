# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
yarn hardhat help
yarn hardhat run scripts/deploy.js
yarn hardhat node
yarn hardhat test
yarn hardhat verify --network goerli {contract address}
REPORT_GAS=true yarn hardhat test
```
****

*Hardhat manages abi and contract bytecode internally making deploying process and working with contracts alot easier. we can manage rpc urls and api keys all in hardhat config files, making working with different networks easier*

## This project demonstrates (using ethers js from hardhat package)

* managing networks in hardhat config file
* doing specific things like verifying according to network in use
* running hardhat tasks in code
* deploying, managing and interacting with  contract in hardhat wrapped etherjs
* verifying solidity contract source code on etherscan (using command line and programmatically)
* creating a custom hardhat task in `hardhat.config.js` file
* creating and running simple test using mocha in `test-deploy.js` file
* hardhat-gas-reporter plugin