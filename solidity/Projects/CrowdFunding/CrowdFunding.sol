// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

error NotOwner(address sender);
error Closed(string message);
error NotEnoughFunds(uint256 received, uint256 required);

contract CrowdFunding {
    uint256 constant DEAD_LINE = 2 minutes;
    uint256 constant MINIMUM_CONTRIBUTION_AMOUNT = 1 ether;

    address immutable owner;
    uint256 immutable deployTime;

    mapping (address => uint256) contributions;

    constructor() {
        owner = msg.sender;
        deployTime = block.timestamp;
    }

    modifier onlyOwner {
        if (msg.sender != owner)
            revert NotOwner(msg.sender);

        _;
    }

    modifier onlyWhenOpen {
        uint256 currentTime = block.timestamp;

        if ((deployTime + DEAD_LINE) < currentTime)
            revert Closed("This funding has been closed. Thanks for visiting :)");

        _;
    }

    function amountCollected() external view onlyOwner returns(uint256) {
        return address(this).balance;
    }

    function withDraw() external onlyOwner {
        (bool success,) = payable(owner).call{value: address(this).balance}("");
        require(success, "Unable to withdraw funds");
    }

    function contribute() public onlyWhenOpen payable {
        if (msg.value < MINIMUM_CONTRIBUTION_AMOUNT)
            revert NotEnoughFunds(msg.value, MINIMUM_CONTRIBUTION_AMOUNT);

        contributions[msg.sender] = contributions[msg.sender] + msg.value;
    }

    receive() external payable {
        contribute();
    }

    fallback() external payable {
        contribute();
    }
}