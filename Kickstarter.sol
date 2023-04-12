// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract Campaign {
    struct Request {
        string description;
        uint256 value;
        address recipient;
        bool complete;
    }

    Request[] public requests;
    address public manager;
    uint256 public minimumContribution;
    address[] private approvers;

    constructor(uint256 _minimumContribution) {
        manager = msg.sender;
        minimumContribution = _minimumContribution;
    }

    // --- MODIFIERS ---

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    // --- PRIVATE ---

    // --- PUBLIC ---

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

    function createRequest(
        string memory _description,
        uint256 _value,
        address _recipient
    ) public restricted {
        Request memory newRequest = Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false
        });
        requests.push(newRequest);
    }
}
