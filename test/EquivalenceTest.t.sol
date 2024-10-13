// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
import {Test,console} from "forge-std/Test.sol";
import {MyYulContract} from "../src/MyYulContract.sol";
import {MySolidityContract} from "../src/MySolidityContract.sol";

contract  EquivalenceTest is Test{
    MyYulContract yulCon;
    MySolidityContract solCon;

    function setUp() public{
        yulCon = new MyYulContract();
        solCon = new MySolidityContract();
    }

    function test_Equivalence(uint256 a, uint256 b) public{
        uint256 solResult = solCon.add(a,b);
        uint256 yulResult = yulCon.add(a,b);
        console.log("solResult:",solResult);
        console.log("yulResult:",yulResult);

        assertEq(solResult,yulResult,"results dont match" );

    }

}
