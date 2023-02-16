// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    uint16 myNumber;

    function storeNumber(uint16 number) public {
        myNumber = number;
    }

    function getNumber() public view returns (uint16) {
        return myNumber;
    }
}