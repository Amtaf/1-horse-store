// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

contract HorseStore {
    uint256 numberOfHorses;
//function selector => 0xcdfead2e
    function updateHorseNumber(uint256 newNumberOfHorses) external {
        numberOfHorses = newNumberOfHorses;
    }
//function selector => 0xe026c017
    function readNumberOfHorses() external view returns (uint256) {
        return numberOfHorses;
    }
}