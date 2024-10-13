// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.1;

contract MyYulContract {
    function add(uint256 a, uint256 b) public pure returns (uint256 result){
        assembly{
            result := add(a,b)
        }
    }
}