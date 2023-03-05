// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    // using library for uint256 so we can call library methods on uint256 directly
    using PriceConverter for uint256;

    uint256 constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address immutable owner;

    // called immediately after contract is deployed
    constructor() {
        // msg.sender in constructor is address of person who deployed contract
        owner = msg.sender;
    }

    // creating custom modifier
    modifier onlyOwner {
        // require(msg.sender == owner, "only owner of the contract can withdraw funds");
        if (msg.sender != owner)
            revert NotOwner();
        // _; means the rest of the code
        _;
    }

    function fund() public payable {
        // we dont need to pass first argument to getConversionRate() method
        // because it considers msg.value (here) as first argument
        require(msg.value.getConversionRate() >= MINIMUM_USD, "come on man give me some more");

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < funders.length; i++)
            addressToAmountFunded[funders[i]] = 0;

        // reseting array
        funders = new address[](0);

        // To send native blockchain currency there are three ways

        // 1. transfer (not recomended)
        // msg.sender = address type
        // payable(msg.sender) = payable type
        // we can only send currency to payable address type in solidity
        payable(msg.sender).transfer(address(this).balance);

        // 2. send (not recomended)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "send failed");

        // 3. call (recomended)
        (bool callSuccess,) =  payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
    }

    // special functions (if someone sends currency to this contract 
    // wihout calling fund function then recieve function will be called automatically)

    // 1. receive
    // this functions is called when calldata is empty and it is assumed that only
    // ether or currency is being sent to this contract
    receive() external payable {
        fund();
    } 

    // 2. fallback
    // this function is called when calldata is not empty and no valid function is being called in transaction
    // it can also be called when calldata is empty but receive function is not implimented
    fallback() external payable {
        fund();
    }
}