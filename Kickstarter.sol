// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract Campaign {
    struct Request {
        string description;
        uint256 value;
        address recipient;
        bool complete;
        uint256 approvalCount;
        mapping(address => bool) approvals;
    }

    uint256 public _numRequest;
    mapping(uint256 => Request) public requests;
    address public manager;
    uint256 public minimumContribution;
    mapping(address => bool) public approvers;
    uint256 public peopleJoinedForContribution;

    constructor(uint256 _minimumContribution, address _creator) {
        manager = _creator;
        minimumContribution = _minimumContribution;
    }

    modifier restricted() {
        require(
            msg.sender == manager,
            "Only the manager can execute this function."
        );
        _;
    }

    function contribute() public payable {
        require(
            msg.value >= minimumContribution,
            "Not enough wei sent to meet the minimum contribution requirement."
        );
        if (!approvers[msg.sender]) {
            peopleJoinedForContribution++;
        }
        approvers[msg.sender] = true;
    }

    function getTotalBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function createRequest(
        string memory _description,
        uint256 _value,
        address _recipient
    ) public restricted {
        Request storage r = requests[_numRequest++];
        r.description = _description;
        r.value = _value;
        r.recipient = _recipient;
        r.complete = false;
        r.approvalCount = 0;
    }

    function approveRequest(uint256 _index) public {
        require(
            approvers[msg.sender],
            "Account is not participating in Campaign."
        );
        require(
            !requests[_index].approvals[msg.sender],
            "User cannot approve same request twice."
        );
        requests[_index].approvals[msg.sender] = true;
        requests[_index].approvalCount++;
    }

    function finalizeRequest(uint256 _index) public payable restricted {
        Request storage r = requests[_index];
        require(
            r.approvalCount > (peopleJoinedForContribution / 2),
            "You do not have required number of approvals."
        );
        require(!r.complete, "Request has been approved already.");

        payable(r.recipient).transfer(r.value);
        r.complete = true;
    }
}
