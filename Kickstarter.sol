// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract Campaign {
    address public manager;
    uint256 public minimumContribution;

    constructor(uint256 minAmount) {
        manager = msg.sender;
        minimumContribution = minAmount;
    }
}
