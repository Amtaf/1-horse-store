// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.8.20;

import {HorseStore} from "../../src/horseStoreV1/HorseStore.sol";
import {IHorseStore} from "../../src/horseStoreV1/IHorseStore.sol";
import {Test,console2} from "forge-std/Test.sol";

abstract contract Base_TestV1 is Test{
    IHorseStore public horseStore;

    //bytes yulCode = b'6000600160e01b81350463cdfead2e811460245763e026c01781146039578182fd6042565b60243610156030578182fd5b60043582556042565b81548252602082f35b5050';
    function setUp() public virtual{
        horseStore = IHorseStore(address(new HorseStore()));

    }

    function testReadValue() public view{
        uint256 initialvalue = horseStore.readNumberOfHorses();
        assertEq(initialvalue, 0);
    }

    function testWriteValue() public{
        uint256 numberOfHorses = 777;
        horseStore.updateHorseNumber(numberOfHorses);
        assertEq(horseStore.readNumberOfHorses(), numberOfHorses);
    }
}