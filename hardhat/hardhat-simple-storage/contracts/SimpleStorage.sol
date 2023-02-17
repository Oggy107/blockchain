// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    uint256 myNumber;

    function storeNumber(uint256 number) public {
        myNumber = number;
    }

    function getNumber() public view returns (uint256) {
        return myNumber;
    }
}