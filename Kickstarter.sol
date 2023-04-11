// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract Campaign {
    address public manager;
    uint256 public minimumContribution;
    address[] public approvers;

    constructor(uint256 minAmount) {
        manager = msg.sender;
        minimumContribution = minAmount;
    }

    function contribute() public payable {
        require(
            msg.value > minimumContribution,
            "Amount trying to send is less than minimum contribution for Campaign."
        );
        approvers.push(msg.sender);
    }
}
