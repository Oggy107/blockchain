const ethers = require("ethers");
const fs = require("fs");

// test-address: 0x2344E87FDa43Deb821ef2661A4f2ce5Df7940eb3
// test-privatekey: 99c6fc500978a4450e142606ba8178c19805a0de6fd5cf0febbe96d7b3d825d9

const TEST_ADDRESS = "0xe2bBb4F3172DCE18C18f0EA9a9F481C157166472";
const TEST_PRIVATEKEY =
    "0x26bfac3b8ca02357c9f20b000d707852bfba79cf0eae28f91d0c3744695fb436";

const init = () => {
    const GANACHE_RPC_URL = "http://127.0.0.1:7545";
    const provider = new ethers.JsonRpcProvider(GANACHE_RPC_URL);

    return provider;
};

const deploy = async (abiPath, binPath, signer) => {
    abi = fs.readFileSync(abiPath);
    bin = fs.readFileSync(binPath);

    contractFactory = new ethers.ContractFactory(abi, bin, signer);
    const contract = await contractFactory.deploy();
    return contract;
};

const main = async () => {
    const provider = init();
    // signer is used when ethers.js instance do not have private key but can request request the local MetaMask instance over its API to sign the transaction when needed
    // const signer = await provider.getSigner(TEST_ADDRESS);
    const signer = new ethers.JsonRpcSigner(provider, TEST_ADDRESS);
    // wallet signer is used when ethers.js instance knows the private key directly
    const wallet = new ethers.Wallet(TEST_PRIVATEKEY, provider);

    contract = deploy(
        "./SimpleStorage_sol_SimpleStorage.abi",
        "./SimpleStorage_sol_SimpleStorage.bin",
        signer
    );

    console.log(contract);

    // console.log(await wallet.getAddress());
    // console.log(await provider.getBlockNumber());
    // console.log(ethers.formatEther(await provider.getBalance(TEST_ADDRESS)));
};

main()
    .then(() => {})
    .catch((err) => {
        console.log(err);
    });
