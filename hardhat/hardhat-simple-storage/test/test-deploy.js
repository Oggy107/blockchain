const chai = require("chai");
const hre = require("hardhat");

const ethers = hre.ethers;

// running tests
// we can run all tests using hardhat test command
// to run specific test file run hardhat test {path to test file}
// to run specific test in a file run it using hardhat test {path to test file} --grep {keyword or substring of testname}
// or we can add to.only in test file to run only that test

describe("SimpleStorage", () => {
    // beforeEach runs before every it
    // we need to deploy our contract before testing it.

    // we need our it()s to have access to our contract so we are declaring them here;
    let simpleStorageContract = null;

    beforeEach(async () => {
        const simpleStorageContractFactory = await ethers.getContractFactory(
            "SimpleStorage"
        );
        simpleStorageContract = await simpleStorageContractFactory.deploy();
        await simpleStorageContract.deployed();
    });

    it("Should start with a favourite number of 0", async () => {
        const number = await simpleStorageContract.getNumber();
        const expectedValue = "0";

        chai.assert.equal(number.toString(), expectedValue);
        //or
        // chai.expect(number.toString()).to.equal(expectedValue);
    });

    it("Should set favourite number to 69", async () => {
        await simpleStorageContract.storeNumber(69);
        const number = await simpleStorageContract.getNumber();
        const expectedValue = "69";

        chai.assert.equal(number.toString(), expectedValue);
    });

    // we can have nested describes to modularize our tests
    // describe("something", () => {
    //     beforeEach()

    //     it()
    //     it()
    //     it()
    // })
});
