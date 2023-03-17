// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error NotOwner(address owner, address currentUser);
error NotOpen(uint256 willOpenIn);

contract Test {
    uint256 public personCount;
    mapping (uint256 => Person) public people;
    address owner;
    uint256 deployTime;

    struct Person {
        uint256 id;
        string firstName;
        string lastName;
    }

    modifier onlyOwner {
        if (msg.sender != owner)
            revert NotOwner(owner, msg.sender);

        _;
    }

    modifier onlyWhenOpen {
        uint256 openingTime = 1 minutes;
        uint256 currentTime = block.timestamp;

        if (currentTime - deployTime < openingTime) {
            revert NotOpen(openingTime - (currentTime - deployTime));
        }

        _;
    }

    constructor() {
        owner = msg.sender;
        deployTime = block.timestamp;
    }

    function addPerson(string memory _firstName, string memory _lastName) public onlyOwner onlyWhenOpen {
        personCount += 1;
        people[personCount] = Person(personCount, _firstName, _lastName);
    }
}