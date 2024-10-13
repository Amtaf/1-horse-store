// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

import {SymTest} from "halmos-cheatcodes/SymTest.sol";
import {Test} from "forge-std/Test.sol";
import {SimpleERC20} from "../src/SimpleERC20.sol";

contract MyTokenTest is SymTest, Test {
    SimpleERC20 token;

    function setUp() public {
        uint256 initialSupply = svm.createUint256('initialSupply');
        token = new MyToken(initialSupply);
    }
}