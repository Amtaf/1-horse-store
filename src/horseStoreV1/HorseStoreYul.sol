// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

contract HorseStoreYul {
    uint256 numberOfHorses;
//function selector => 0xcdfead2e
    function updateHorseNumber(uint256 newNumberOfHorses) external {
        //numberOfHorses = newNumberOfHorses;
        assembly{
            sstore(numberOfHorses.slot, newNumberOfHorses)

        }
    }
//function selector => 0xe026c017
    function readNumberOfHorses() external view returns (uint256) {
        //return numberOfHorses;
        assembly{
            let num := sload(numberOfHorses.slot)
            mstore(0,num)
            return(0,0x20)
        }
    }
}