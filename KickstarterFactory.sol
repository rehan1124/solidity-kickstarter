// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

import {Campaign} from "./Kickstarter.sol";

contract CampaignFactory {
    address[] public deployedCampaign;

    function createCampaign(uint256 _minimumContribution) public {
        Campaign newCampaign = new Campaign(_minimumContribution, msg.sender);
        deployedCampaign.push(address(newCampaign));
    }

    function getDeployedCampaigns() public view returns (address[] memory) {
        return deployedCampaign;
    }
}
