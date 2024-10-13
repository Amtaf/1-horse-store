// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract  OpcodesExample2{
    uint256 result;

    function add (uint256 a, uint256 b) public {
        assembly {
            let addresult := add(a,b)
            sstore(result.slot, addresult)
        }
    }

    function mulOrDiv (uint256 a, uint256 b) public {
        if(a == 0 || b == 0){
            assembly {
                stop()
            }
        }
        uint256 modR;
        assembly {
            modR := mod(a,b)
        }

        if(modR == 0) {
            assembly {
                let mulDivResult := div(a,b)
                sstore(result.slot, mulDivResult)
            }
        }

        assembly {
            let mulResult := mul(a,b)
            sstore(result.slot, mulResult)
        }
    }

    function sub(uint256 a, uint256 b) public pure returns(uint256 subresult) {
        assembly {
            subresult := sub(a,b)
        }
    }

    function get() public view returns(uint256){
        return result;
    }

    function conditionOperation (uint256 a, uint256 b) public pure returns(uint256 cresult){
        if(a>b){
            assembly {
                cresult := addmod(a, b, 2)
            }
        }

        assembly {
            cresult := mulmod(a, b, 2)
        }
    }

    function signedOp(int16 a, int16 b) public pure returns (int16 sResult){
        int8 signmod;
        assembly {
            signmod := smod(a,b)
        }

        if (signmod == 0) {
            assembly {
                sResult := sdiv(a,b)
            }
        }
    }
}
