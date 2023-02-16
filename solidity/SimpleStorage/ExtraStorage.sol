// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    function storeNumber(uint16 number) public override  { myNumber = number + 5; }
}