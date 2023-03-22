// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    /**
     * @dev Returns name of the token
     * @return Name of the token
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns symbol of the token
     * @return Token symbol
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the account balance of another account with address _owner
     */
    function balanceOf(address _owner) external view returns (uint256 balance);

    /**
     * @dev Returns the total token supply.
     */
    function totalSupply() external pure returns (uint256);

    /**
     * @dev Transfer token from sender to another account
     * @param _to transfer token to this address
     * @param _value amount of token to transfer
     */
    function transfer(address _to, uint256 _value) external returns (bool success);

    /**
     * @dev Approve another address to spend your tokens
     * @param _spender approve this address to spend your tokens
     */
    function approve(address _spender, uint256 _value) external returns (bool success);

    /**
     * @dev Returns the amount which _spender is still allowed to withdraw from _owner
     * @param _owner owner of the tokens
     * @param _spender spender of the tokens
     */
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);

    /**
     * @dev Transfers _value amount of tokens from address _from to address _to, and MUST fire the Transfer event
     * @param _from address to transfer tokens from
     * @param _to address to which transfer tokens to
     * @param _value ammount of tokens to transfer
     */
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    /**
     * @dev Triggers when tokens are transferred, including zero value transfers
     * @param _from from address
     * @param _to to address
     * @param _value amount of tokens
     */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * @dev Triggers on any successful call to approve(address _spender, uint256 _value)
     * @param _owner owner of the tokens
     * @param _spender spender of the tokens
     * @param _value amount of tokens
     */
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}