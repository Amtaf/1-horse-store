// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;


import {Test} from "forge-std/Test.sol";
import {OpcodesExample2} from "../../src/OpcodesExample2.sol";

contract TestOpcodesExample is Test{

    OpcodesExample2 public OpcodesExample;

     function setUp() external {
        OpcodesExample = new OpcodesExample2();
    }

   
    function testFuzz_add(uint256 a, uint256 b) external {
        a = bound({x: a, min: 1, max: type(uint128).max - 1});
        b = bound({x: b, min: 1, max: type(uint128).max - 1});

        // add the value
        OpcodesExample.add(a, b);

        // Compute the expected result
        uint256 expected_result = a + b;

        // Read the result from storage
        uint256 stored_result = OpcodesExample.get();
        assertEq(stored_result, expected_result);
    }

        function testFuzz_mulOrDiv(uint256 a, uint256 b) external {
        a = bound({x: a, min: 1, max: type(uint256).max});
        b = bound({x: b, min: 1, max: type(uint256).max});

        OpcodesExample.mulOrDiv(a, b);

        // Compute the expected result
         uint256 expected_result = a * b;

        // // Read the result from storage
        uint256 stored_result = OpcodesExample.get();
        assertEq(stored_result, expected_result);
    }

    function testFuzz_sub(uint256 a, uint256 b) external view{
        a = bound({x: a, min: 1, max: type(uint256).max});
        b = bound({x: b, min: 1, max: type(uint256).max});

        OpcodesExample.sub(a, b);
    }

    function testFuzz_conditionOperation(uint256 a, uint256 b) external view{
        a = bound({x: a, min: 1, max: type(uint256).max});
        b = bound({x: b, min: 1, max: type(uint256).max});

        OpcodesExample.conditionOperation(a, b);
    }

    function testFuzz_signedOp(int16 a, int16 b) external {
       //a = bound({x: a, min: type(int16).min, max: type(int16).max});
        //b = bound({x: b, min: type(int16).min, max: type(int16).max});

        OpcodesExample.signedOp(a, b);
    }

}