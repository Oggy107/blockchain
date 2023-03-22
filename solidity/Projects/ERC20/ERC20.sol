// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IERC20.sol";

error NotEnoughTokens(uint256 available);
error NotAllowed();

contract ERC20 is IERC20 {
    uint256 constant private _TOTAL_SUPPLY = 21000;

    string private _name;
    string private _symbol;
    mapping (address => uint256) private _balances;
    mapping (address => mapping(address => uint256)) private _allowed;

    constructor(string memory __name, string memory __symbol) {
        _name = __name;
        _symbol = __symbol;
        _balances[msg.sender] = _TOTAL_SUPPLY;
    }

    function name() external view returns(string memory) {
        return _name;
    }

    function symbol() external view returns(string memory) {
        return _symbol;
    }

    function totalSupply() external pure returns(uint256) {
        return _TOTAL_SUPPLY;
    }

    function balanceOf(address _owner) public view returns(uint256 balance) {
        return _balances[_owner];
    }

    function transfer(address _to, uint256 _value) external returns(bool sucess) {
        if (_value > balanceOf(msg.sender))
            revert NotEnoughTokens(balanceOf(msg.sender));

        _balances[msg.sender] = _balances[msg.sender] - _value;
        _balances[_to] = _balances[_to] + _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) external returns (bool success) {
        if (_value > balanceOf(msg.sender))
            revert NotEnoughTokens(balanceOf(msg.sender));

        _allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool sucess) {
        if (_value > balanceOf(_from))
            revert NotEnoughTokens(balanceOf(_from));

        if (_value > _allowed[_from][msg.sender])
            revert NotAllowed();

        _balances[_from] = _balances[_from] - _value;
        _balances[_to] = _balances[_to] + _value;
        _allowed[_from][msg.sender] = _allowed[_from][msg.sender] - _value;

        emit Transfer(_from, _to, _value);

        return true;
    }

    function allowance(address _owner, address _spender) external view returns (uint256 remaining) {
        return _allowed[_owner][_spender];
    }
}