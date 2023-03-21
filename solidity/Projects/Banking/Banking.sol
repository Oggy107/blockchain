// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Banking {
    mapping (address => uint256) balances;

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function deposit() external payable {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }

    function withdraw(uint256 _amount) external payable {
        balances[msg.sender] = balances[msg.sender] - _amount;
        (bool success,) = payable(msg.sender).call{value: _amount}("");

        require(success, "withdraw failed!");
    }

    function transfer(address _to, uint256 _amount) external payable {
        balances[msg.sender] = balances[msg.sender] - _amount;
        (bool success,) = payable(_to).call{value: _amount}("");

        require(success, "transfer failed!");
        balances[_to] = balances[_to] + _amount;
    }
}