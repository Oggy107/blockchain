// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error NotOwner(address sender);
error NotEnoughFunds(string message, uint256 minimum_amount_required);
error NotEnoughParticipants(string message, uint256 minimum_participants);
error AlreadyAParticipant();

contract Lottery {
    uint256 constant TICKET_PRICE = 1 ether;
    uint256 constant MINIMUM_PARTICIPANTS = 5;
    address owner;
    address[] participants;
    uint256 public participantCount;

    modifier onlyOwner {
        if (msg.sender != owner)
            revert NotOwner(msg.sender);

        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function transferFundsToOwner(uint256 _amount) internal {
        (bool success,) = payable(owner).call{value: _amount}("");

        require(success, "Unable to transfer funds to owner");
    }

    function getRandomNumber(uint256 _upperBound) internal view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.number, block.timestamp, participantCount))) % _upperBound;
    }

    function buyTicket() public payable  {
        if (msg.value <= TICKET_PRICE)
            revert NotEnoughFunds("You do not have enough funds to buy ticket", TICKET_PRICE);
        
        for (uint256 i = 0; i < participantCount; i++) {
            if (msg.sender == participants[i])
                revert AlreadyAParticipant();
        }
        
        participants.push(msg.sender);
        participantCount += 1;
    }

    function getBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    function selectWinner() external onlyOwner returns (address) {
        if (participantCount < MINIMUM_PARTICIPANTS)
            revert NotEnoughParticipants("There are not enough participants. Please wait...", MINIMUM_PARTICIPANTS);

        address winner = participants[getRandomNumber(participantCount)];

        (bool success,) = payable(winner).call{value: address(this).balance}("");

        require(success, "unbale to transfer funds to winner");

        return winner;
    }

    receive() external payable {
        buyTicket();
    }

    fallback() external payable {
        buyTicket();
    }
}