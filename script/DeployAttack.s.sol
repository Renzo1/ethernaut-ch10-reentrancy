// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract DeployAttack is Script {
    function run() external returns (Attack) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address payable reentrancyAddr = payable(
            0xAae8c5268CD81271f608F89fCdA5c6904b5345C7
        );

        vm.startBroadcast(deployerPrivateKey);

        Attack attack = new Attack(reentrancyAddr);

        vm.stopBroadcast();

        return (attack);
    }
}
