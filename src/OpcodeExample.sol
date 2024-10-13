// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OpcodeExample {
    function useOpcodes(uint256 a, uint256 b) public pure returns(uint256,uint256,uint256,uint256) {
        uint256 addResult;
        uint256 mulResult;
        uint256 subResult;
        uint256 divResult;
        uint256 sdivResult;
        uint256 modResult;
        uint256 smodResult;
        uint256 addmodResult;
        //uint256 mulmodResult;

        assembly {
            // ADD
            addResult := add(a, b)
            // MUL
            mulResult := mul(a, b)
            // SUB
            subResult := sub(a, b)
            // DIV
            divResult := div(a, b)
            // SDIV
            sdivResult := sdiv(a, b)
            // // MOD
             modResult := mod(a, b)
            // // SMOD
            smodResult := smod(a, b)

            addmodResult:= addmod(a, b, 100)
        }

        return (
            addResult,
            mulResult,
            subResult,
            divResult
            //sdivResult
            //modResult
           // smodResult
                             );
    }
}
