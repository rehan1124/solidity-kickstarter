// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract Campaign {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }

    address public manager;
    uint256 public minimumContribution;
    address[] private approvers;

    constructor(uint256 _minimumContribution) {
        manager = msg.sender;
        minimumContribution = _minimumContribution;
    }

    function contribute() public payable {
        require(
            msg.value >= minimumContribution,
            "Not enough wei sent to meet the minimum contribution requirement."
        );
        approvers.push(msg.sender);
    }

    function getApprovers() public view returns (address[] memory) {
        return approvers;
    }

    function getTotalBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
