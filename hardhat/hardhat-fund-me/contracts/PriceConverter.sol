// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// we can not have state variables in library and functions must be internal
library PriceConverter {
    /**
    Network: Goerli
    Aggregator: ETH/USD
    Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    */
    function getPrice() internal view returns(uint256) {
        // we need ABI and contract address to interact with external contract
        // ABI is provided by interfaces in solidity and we can pass contract address
        // to interface to start interacting with external contract
        (,int256 price,,,) = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e).latestRoundData();

        // ETH price in USD
        // we need to convert price to msg.value() units which is Wei
        return uint256(price * 1e10); // 1 ** 10 = 10000000000
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        return (ethPrice * ethAmount) / 1e18;
    }
}