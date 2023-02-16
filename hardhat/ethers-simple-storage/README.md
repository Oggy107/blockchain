# Basic ethers js example

## How to run

* install dependencies using `yarn install`

* compile solidity
    ```
    yarn compile SimpleStorage.sol
    ```

* run ganache instance locally and change address in deploy.js accordingly

* run with `node deploy.js`

## Deploy.js demonstrates (using ethers js)

* Basic ethers js concepts (provider, signer, contract)
* how to deploy contract (with contractFactory)
* deploy contract by signing and sending transaction manualy
* how to interact with already deployed contract