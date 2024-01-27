# Module_21_Martian_Token_Crowdsale
Ethereum blockchain and virtual machine smart contracts built using the ERC-20 standard and OpenZepplin libraries to mint a fungible token ('KaseiCoin') and facilitate its crowdsale.



# Deviations from instructions
## Instructions at Step 2.4
Requirement: Compile the contract by using compiler version 0.5.0.   
Deviation: Compiled the contract using compiler version 0.5.5 and setting EVM to `constantinople`.   
Justification: Using version 0.5.0 and the default EVM generated the following compile errors:
> https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/utils/Address.sol:1:1: SyntaxError: Source file requires different compiler version (current compiler is 0.5.0+commit.1d4f565a.Emscripten.clang - note that nightly builds are considered to be strictly less than the released version
pragma solidity ^0.5.5;   
^---------------------^   
   
> .deps/github/OpenZeppelin/openzeppelin-contracts/contracts/utils/Address.sol:31:32: TypeError: The "extcodehash" instruction is only available for Constantinople-compatible VMs  (you are currently compiling for "byzantium").
        assembly { codehash := extcodehash(account) }
                               ^------------------^