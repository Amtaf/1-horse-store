//0x6080604052348015600e575f80fd5b5060a58061001b5f395ff3fe6080604052348015600e575f80fd5b50600436106030575f3560e01c8063cdfead2e146034578063e026c017146045575b5f80fd5b6043603f3660046059565b5f55565b005b5f5460405190815260200160405180910390f35b5f602082840312156068575f80fd5b503591905056fea26469706673582212209bc251171c067d1b83574ce700590f0c2db3a8afb667d54f8e69ea8a3536470f64736f6c63430008140033

//3 sections of 
//1. Contract Creation code
//2. Runtime
//3. Metadata

//1. Contract Creation code
PUSH1 0x80   //push 0x80 to the stack [0x80]
PUSH1 0x40   //push 0x40 to the stack [0x40,0x80]
MSTORE       //[]   
//if someone sent value with this call,jump to the 0x0E PC/JumpDest
CALLVALUE    //[msg.value]
DUP1         //[msg.value,msg.value]
ISZERO       //[msg.value == 0,msg.value]   
PUSH1 0x0e    //[0x0E,msg.value == 0,msg.value]  
JUMPI         //[msg.value]
PUSH0         // [0x00, msg.value] 
DUP1           // [0x00,0x00, msg.value] 
REVERT          //[msg.value]

//Jump dest if msg.value == 0 
JUMPDEST        //[msg.value]
POP             //[]
PUSH1 0xa5      //[0xa5]
DUP1            //[0xa5,0xa5]
PUSH2 0x001b    //[0x001b,0xa5,0xa5]
PUSH0           //[0x00,0x001b,0xa5,0xa5]
CODECOPY        //[0xa5]      Memory:[runtime code]
PUSH0           //[0x00,0xa5]
RETURN          //[]
INVALID         //[]    

//Runtime code
//Entry point of all calls
//the first 3 are the Free memory pointer
PUSH1 0x80
PUSH1 0x40
MSTORE
//checking for msg.value and if given revert
CALLVALUE       //[msg.value]
DUP1            //[msg.value, msg.value]
ISZERO          //[msg.value == 0,msg.value]
PUSH1 0x0e      //[0x0e,msg.value == 0,msg.value]
JUMPI           //[msg.value] if msg.value is 0 go to 0x0e
//Jump to continue! if msg.value == 0
PUSH0           //[0x00,msg.value]
DUP1            //[0x00,0x00,msg.value]
REVERT          //[msg.value]

//if msg.value == 0, start here!
//continue!
JUMPDEST        //[msg.value]
POP             //[]
PUSH1 0x04      //[0x04] push 0x04 to the stack
CALLDATASIZE     //[calldata_size,0x04]   
LT               //[calldata_size<0x04]
PUSH1 0x30       //[0x30,calldata_size<0x04]
JUMPI             //[]
//if 0 calldata_size<0x04 ->calldata_jump

PUSH0           //[0]
CALLDATALOAD    //[32 bytes of calldata]
PUSH1 0xe0      //[0xe0, 32bytes of calldata]
SHR             //[calldata[0:4]] <-- function_selector shift the 32 bytes calldata by 0xe0
DUP1            //[func_selector, func_selector]
PUSH4 0xcdfead2e    //[0xcdfead2e,func_selector, func_selector]
EQ                  //[func_selector == 0xcdfead2e,func_selector ]
PUSH1 0x34          //[0x34,func_selector == 0xcdfead2e,func_selector ]
JUMPI               //[func_selector]
//if func_selector == 0xcdfead2e -> set_number_of_horses
// function dispatching for readNumberOfHorses

DUP1                //[func_selector, func_selector]
PUSH4 0xe026c017    //[0xe026c017,func_selector, func_selector]
EQ                  //[func_selector == 0xe026c017,func_selector]
PUSH1 0x45          //[0x45,func_selector == 0xe026c017,func_selector]
JUMPI               //[func_selector]
//calldata jump
//Revert Jumpdest if no func_selector was set
JUMPDEST            //[]
PUSH0               //[0]
DUP1                //[0,0]
REVERT              //[0]

//updateHorseNumber Jumpdest 1
JUMPDEST            //get [func_selector]
PUSH1 0x43          //[0x43, func_selector]
PUSH1 0x3f          //[0x3f,0x43, func_selector]
CALLDATASIZE        //[calldata_size,0x3f,0x43, func_selector]
PUSH1 0x04          //[0x40,calldata_size,0x3f,0x43, func_selector]
PUSH1 0x59          //[0x59,0x40,calldata_size,0x3f,0x43, func_selector]
JUMP                //[0x40,0x59,0x40,calldata_size,0x3f,0x43, func_selector]
JUMPDEST
PUSH0
SSTORE
JUMP
JUMPDEST
STOP
JUMPDEST
PUSH0
SLOAD
PUSH1 0x40
MLOAD
SWAP1
DUP2
MSTORE
PUSH1 0x20
ADD
PUSH1 0x40
MLOAD
DUP1
SWAP2
SUB
SWAP1
RETURN

//updateHorseNumber jump dest 2
//checks to see if theres a value to update the horse number to
//The total calldata should be 4 bytes for the function selector and 32 bytes for the horse number
JUMPDEST         //[0x40,calldata_size,0x3f,0x43, func_selector]
PUSH0             //[0,0x40,calldata_size,0x3f,0x43, func_selector]
PUSH1 0x20        //[0x20,0,0x40,calldata_size,0x3f,0x43, func_selector]
DUP3              //[0x40,0x20,0,0x40,calldata_size,0x3f,0x43, func_selector]
DUP5              //[calldata_size,0x40,0x20,0,0x40,calldata_size,0x3f,0x43, func_selector]
SUB               //[calldata_size-0x40,0x20,0,0x40,calldata_size,0x3f,0x43, func_selector]
//is there more calldata than the function selector?
SLT               //[calldata_size-0x40<0x20,0,0x40,calldata_size,0x3f,0x43, func_selector]
ISZERO             //[morecalldataThanSelector,0,0x40,calldata_size,0x3f,0x43, func_selector]
PUSH1 0x68          //[0x68,morecalldataThanSelector,0,0x40,calldata_size,0x3f,0x43, func_selector]
JUMPI               //[0,0x40,calldata_size,0x3f,0x43, func_selector]
//we are going to jump dest3 if theres more calldata than 
//function selector +0x20 

//Revert if there isnt enough calldata
PUSH0           //[0,0,0x40,calldata_size,0x3f,0x43, func_selector]
DUP1            //[0,0,0,0x40,calldata_size,0x3f,0x43, func_selector]
REVERT          //[0,0x40,calldata_size,0x3f,0x43, func_selector]

//updateHorseNumber jumpdest 3
JUMPDEST        //[0,0x40,calldata_size,0x3f,0x43, func_selector]
POP             //[0x40,calldata_size,0x3f,0x43, func_selector]
CALLDATALOAD    //[calldata(of number to update),0x40,calldata_size,0x3f,0x43, func_selector]
SWAP2
SWAP1
POP
JUMP
INVALID
LOG2
PUSH5 0x6970667358
INVALID
SLT
KECCAK256
SWAP12
INVALID
MLOAD
OR
SHR
MOD
PUSH30 0x1b83574ce700590f0c2db3a8afb667d54f8e69ea8a3536470f64736f6c63
NUMBER
STOP
ADDMOD
EQ
STOP
CALLER