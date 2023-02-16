const ethers = require("ethers");

// test-address: 0x2344E87FDa43Deb821ef2661A4f2ce5Df7940eb3
// test-privatekey: 99c6fc500978a4450e142606ba8178c19805a0de6fd5cf0febbe96d7b3d825d9

const TEST_ADDRESS = "0x2344E87FDa43Deb821ef2661A4f2ce5Df7940eb3";
const TEST_PRIVATEKEY =
    "99c6fc500978a4450e142606ba8178c19805a0de6fd5cf0febbe96d7b3d825d9";

const init = () => {
    const GANACHE_RPC_URL = "http://127.0.0.1:7545";
    const provider = new ethers.JsonRpcProvider(GANACHE_RPC_URL);

    return [provider, provider.getSigner()];
};

const main = async () => {
    const [provider, signer] = init();
    // const wallet = new ethers.Wallet(TEST_PRIVATEKEY, provider);

    // console.log(await wallet.getAddress());
    console.log(await provider.getBlockNumber());
    console.log(ethers.formatEther(await provider.getBalance(TEST_ADDRESS)));
};

main()
    .then(() => {})
    .catch((err) => {
        console.log(err);
    });
