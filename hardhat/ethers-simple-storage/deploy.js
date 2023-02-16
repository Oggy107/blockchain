const ethers = require("ethers");
const fs = require("fs");
require("dotenv").config();

// change these addresses in .env file according to your ganache configurations
const GANACHE_PUBLIC_ADDRESS = process.env.GANACHE_PUBLIC_ADDRESS;
const GANACHE_PRIVATEKEY = process.env.GANACHE_PRIVATEKEY;
const GANACHE_CONTRACT_ADDRESS = process.env.GANACHE_CONTRACT_ADDRESS;
const GANACHE_RPC_URL = process.env.GANACHE_RPC_URL;

const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const GOERLI_PUBLIC_ADDRESS = process.env.GOERLI_PUBLIC_ADDRESS;

const deploy = async (abiPath, binPath, signer) => {
    abi = fs.readFileSync(abiPath, "utf-8");
    bin = fs.readFileSync(binPath, "utf-8");

    contractFactory = new ethers.ContractFactory(abi, bin, signer);
    const contract = await contractFactory.deploy();

    // deployment transaction or transaction response is what you get when you create your transaction
    // const deploymentTransaction = contract.deployTransaction;
    // transaction receipt is what you get when you wait for a block confirmation
    // const transactionReceipt = await contract.deployTransaction.wait(1);

    return contract;
};

const deployWithTxData = async (signer) => {
    const tx = {
        nonce: await signer.getNonce(),
        gasPrice: "20000000000",
        gasLimit: "1000000",
        to: null,
        value: 0,
        // binary data (compiled solidity code)
        data: "0x608060405234801561001057600080fd5b50610177806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c8063e1676da41461003b578063f2c9ecd814610057575b600080fd5b610055600480360381019061005091906100ea565b610075565b005b61005f610094565b60405161006c9190610126565b60405180910390f35b806000806101000a81548161ffff021916908361ffff16021790555050565b60008060009054906101000a900461ffff16905090565b600080fd5b600061ffff82169050919050565b6100c7816100b0565b81146100d257600080fd5b50565b6000813590506100e4816100be565b92915050565b600060208284031215610100576100ff6100ab565b5b600061010e848285016100d5565b91505092915050565b610120816100b0565b82525050565b600060208201905061013b6000830184610117565b9291505056fea264697066735822122025cea7fd9a21d08a613cd5844bd57cecb31586d1791caf9851c177d6756e4ffc64736f6c63430008120033",
        // default ganache chainId
        chainId: 1337,
    };

    // signing a transaction
    // const signedTxResponse = await signer.signTransaction(tx);
    // console.log(signedTxResponse);

    // sending a transaction
    const sentTxResponse = await signer.sendTransaction(tx);
    console.log(sentTxResponse);
};

const interactWithContract = async (
    abiPath,
    contractAddress,
    provider,
    numberToSet,
    signer = null
) => {
    const abi = fs.readFileSync(abiPath, "utf-8");

    // if contract runner is provider we can only call read only methods and if it is signer we can call state changing methods as well
    let contract = new ethers.Contract(contractAddress, abi, provider);

    // calling read-only methods from contract
    let number = await contract.getNumber();
    console.log(`Previous Number: ${number.toString()}`);

    // to call state changing methods you need to connect contract to signer
    contract = contract.connect(signer);
    // we should pass numbers as string for example "72323" insead of 72323
    // this is because javascript can not understand big numbers if we want to pass crazy big number to our solidity contract
    const transactionResponse = await contract.storeNumber(numberToSet);
    // we can wait for block confirmation just like we can wait when deploying contract (deploying contract and calling state changing functions are ultimately both transactions)
    // const transactionReceipt = await transactionResponse.wait(1);

    number = await contract.getNumber();
    console.log(`New Number: ${number.toString()}`);
};

const deployOverTestnet = async () => {
    const provider = new ethers.JsonRpcProvider(GOERLI_RPC_URL);
    console.log(
        ethers.formatEther(await provider.getBalance(GOERLI_PUBLIC_ADDRESS))
    );

    // we can deploy the contract in same way as we deployed it on local blockchain network
    // ofcourse you need to private key from the network to sign the transaction to deploy contract
};

const main = async () => {
    const provider = new ethers.JsonRpcProvider(GANACHE_RPC_URL);

    // signer is used when ethers.js instance do not have private key but can request request the local MetaMask instance over its API to sign the transaction when needed
    // const signer = await provider.getSigner(TEST_ADDRESS);
    const signer = new ethers.JsonRpcSigner(provider, GANACHE_PUBLIC_ADDRESS);
    // wallet signer is used when ethers.js instance knows the private key directly
    const wallet = new ethers.Wallet(GANACHE_PRIVATEKEY, provider);

    console.log(await wallet.getAddress());
    console.log(await provider.getBlockNumber());
    console.log(
        ethers.formatEther(await provider.getBalance(GANACHE_PUBLIC_ADDRESS))
    );

    // contract = await deploy(
    //     "./SimpleStorage_sol_SimpleStorage.abi",
    //     "./SimpleStorage_sol_SimpleStorage.bin",
    //     signer
    // );

    // console.log(contract);

    // await deployWithTxData(wallet);

    // interactWithContract(
    //     "./SimpleStorage_sol_SimpleStorage.abi",
    //     TEST_CONTRACT_ADDRESS,
    //     provider,
    //     22,
    //     wallet
    // );

    // deployOverTestnet();
};

main()
    .then(() => {})
    .catch((err) => {
        console.log(err);
    });
