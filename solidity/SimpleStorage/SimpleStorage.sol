// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    uint16 myNumber;

    function storeNumber(uint16 number) public virtual { myNumber = number; }

    function getNumber() view public returns(uint16) { return myNumber; }
}