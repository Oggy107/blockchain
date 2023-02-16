// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract HelloWorld {
    string word = "Hello World";

    function greet() public view returns(string memory) {
        return word;
    }

    function setWord(string memory _word) public {
        word = _word;
    } 
}