// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] simpleStorageArray;

    function createSimpleStorageContract() public {
        simpleStorageArray.push(new SimpleStorage());
    }

    function getSimpleStorageContractAddress(uint16 index) public view returns(address) {
        return address(simpleStorageArray[index]);
    }

    // returns last simplestorage contract address
    function getSimpleStorageContractAddress() public view returns(address) {
        return address(simpleStorageArray[simpleStorageArray.length - 1]);
    }

    function sfStore(uint16 number, uint16 index) public {
        simpleStorageArray[index].storeNumber(number);
    }

    // stores number in last simpleStorage contract
    function sfStore(uint16 number) public {
        simpleStorageArray[simpleStorageArray.length - 1].storeNumber(number);
    }

    function sfGet(uint16 index) public view returns(uint16) {
        return simpleStorageArray[index].getNumber();
    }

    // gets number from last simpleStorage contract
    function sfGet() public view returns(uint16) {
        return simpleStorageArray[simpleStorageArray.length - 1].getNumber();
    }
}