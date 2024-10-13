//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract YulStorage{
    uint256 public amount; //slot 0
    uint256 val1 = 54;  //slot 1
    uint256 val2 = 594; //slot 2
    uint256 val3 = 452; //slot 3
    uint128 x; //slot4 
    uint128 y;//possibly slot 4

//In solidity the variables that can fit into a word(256 bits) are packed together 
    function getSlot() external pure returns (uint256 s){
        assembly {
            s := y.slot
        }

    }

    function getValStorage (uint256 slotIndex) external view returns (uint r){
        assembly{
            //.slot gives the slot location ,sload loads the value stored in that slot
            r := sload(slotIndex)
        }
        }
     //Risky to write this in production code coz you can pick any arbitrary slot and change its value e.g slot 99  
    function setValueBySlotIndexandVal(uint slotIndex, uint newVal) external{
        assembly{
             sstore(slotIndex, newVal)
        }

    }
    function setVal(uint256 v) external {
        amount=v;

    }
    function getVal() external view returns(uint){
        return amount;
}
}