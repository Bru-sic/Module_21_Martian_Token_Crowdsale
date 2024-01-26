// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

/// @author Bruno Ivasic
/// @title KaseiCoin: An ERC-20 fungible token built on the Ethereum blockchain and virtual machine.

/** @notice
DISCLAIMER
==========
1. The smart contract included in this project is provided as is.
2. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the
    user interface or of the smart contract itself.
3. This smart contract has not been independently audited and as such there is no assurance that it will work as intended.
    Users may experience delays, failures, errors, omissions, loss of transmitted information, or financial loss.
4. No warranty of merchantability, non-infringement or fitness for any particular purpose is made.
5. Use of this smart contract may be restricted or prohibited under applicable law, including securities laws.
6. Advice from competent legal counsel is strongly recommended before considering use of this smart contract.
7. Information provided in this repository shall not be construed as investment advice or legal advice, and is not meant
    to replace competent legal counsel.
*/

/// @dev Import ERC-20 libraries from OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

/// @dev Create the KaseiCoin contract which inherits the OpenZeppelin ERC-20 classes defined in the libraries.
contract KaseiCoin is ERC20, ERC20Detailed, ERC20Mintable {
    /** @notice
    Defines the KaseiCoin constructor which is called once only when the smart contract is deployed.
    The KaseiCoin constructor calls the ERC20Detailed constructor and mints the specified initial supply of tokens.
    */ 
    /// @param name The token's name.
    /// @param symbol The token's symbol (ticker code).
    /// @param initial_supply The token's initial supply.
    constructor(
        string memory name,
        string memory symbol,
        uint initial_supply
    )
        /// @dev Call the ERC20Detailed contstructor passing through the token's name, symbol and `18` being the precision of how many decimal places the token can be subdivided into.
        ERC20Detailed(name, symbol, 18)
        public
    {
        /// @dev Mint the initial supply, setting the Minter Role to the initial creator of the contract
        mint(msg.sender, initial_supply);
    }
}
