//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentAddress) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentAddress)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %S ", SEND_VALUE);
    }

    function Run() external {
        address mostRecentAddressDeployed = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);
        fundFundMe(mostRecentAddressDeployed);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentAddress) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentAddress)).withdraw();
        vm.stopBroadcast();
    }

    function Run() external {
        address mostRecentAddressDeployed = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);
        withdrawFundMe(mostRecentAddressDeployed);
    }
}
