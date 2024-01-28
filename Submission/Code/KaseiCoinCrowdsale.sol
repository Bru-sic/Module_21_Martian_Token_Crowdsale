// SPDX-License-Identifier: MIT
pragma solidity ^0.5.5;

/// @author Bruno Ivasic
/// @title KaseiCoinCrowdsale: A smart contract for deploying and managing the KaseiCoin token crowdsale, and allowing investors to purchase KaseiCoin tokens with ether (ETH).

/// @dev Note: requires compiler 0.5.5+ and EVM constantinople to avoid compiler errors and warnings.

/// @dev Import the KaseiCoin contract from the local repository so it can be used as part of the crowdsale contract
import "./KaseiCoin.sol";

/// @dev Import the Crowdsale and MintedCowdsale libraries from OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


/// @dev Define the KaseiCoinCrowdsale contract composed of the KaseiCoin token classs and inheriting the OpenZeppelin Crowdsale and MintedCrowdsale contract classes.
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    /** @notice Defines the KaseiCoinCrowdsale constructor which is called once only when the smart contract is deployed.
     * The KaseiCoinCrowdsale constructor calls the Crowdsale constructor.
     * @param rate The number of KaseiCoin token units a buyer receives for each wei.
     * @dev `rate` is the conversion between wei and the smallest and indivisible
     * KaseiCoin token unit. As, the KaseiCoin token has been created with a `decimal` of '18' then
     * a `rate` of 1 means the investor would receive 1E-18 (0.000,000,000,000,000,001) KaseiCoin tokens per wei or in
     * other words, 1 Token for each ETH.
     * @param wallet Address where collected funds will be forwarded to - ie usually the Crowdsale organiser's wallet.
     * @param token The KaseiCoin token smart contract being sold once deployed.
     */
    constructor(
        uint rate,
        address payable wallet,
        KaseiCoin token
    ) public Crowdsale(rate, wallet, token) {
        /// @dev The KaseiCoinCrowdsale constructor is currently empty as the call to the Crowdsale is done just above as pert of the constructor declaration.
    }
}


/** @notice Define the KaseiCoinCrowdsaleDeployer contract, which automates deployment of the KaseiCoinCrowdsale and the KaseiCoin contracts.
 *  * Creates an instance of the KaseiCoin token contract, storing the KaseiCoin contract's deployment address;
 *  * Creates a KaseiCoinCrowdsale contract to facilitate investors purchasing the token, storing the KaseiCoinCrowdsale contract's deployment address;
 *  * Assigns the minter role of KaseiCoin tokens to the KaseiCoinCrowdsale contract; and
 *  * Renounces the minter role from the original creator of the KaseiCoin contract to avoid any potential for nefarious minting. 
 */
contract KaseiCoinCrowdsaleDeployer {
    /// @dev Public address of the deployed KaseiCoin smart contract.
    address public kasei_token_address;    
    /// @dev Public address of the deployed KaseiCoinCrowdsale smart contract.
    address public kasei_crowdsale_address;

    /** @notice Define the KaseiCoinCrowdsaleDeployer constructor which is called once only when the KaseiCoinCrowdsaleDeployer smart contract is deployed.
     * The KaseiCoinCrowdsaleDeployer constructor:
     *  * Creates an instance of the KaseiCoin token contract, storing the KaseiCoin contract's deployment address in `kasei_token_address`;
     *  * Creates a KaseiCoinCrowdsale contract to facilitate investors purchasing the token, storing the KaseiCoinCrowdsale contract's deployment address in `kasei_crowdsale_address`;
     *  * Assigns the minter role of KaseiCoin tokens to the KaseiCoinCrowdsale contract; and
     *  * Renounces the minter role from the original `msg.sender` to avoid any potential for nefarious minting. 
     *  
     * @param name The name given to the KaseiCoin token.
     * @param symbol The (ticker) symbol given to the KaseiCoin token.
     * @param wallet The Ethereum Address that will receive the funding as investors purchase KaseiCoin tokens via the KaseiCoinCrowdsale contract.
     */
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet ) public {

        /// @dev Create an instance of the `KaseiCoin` token contract,
        /// @dev with an initial supply of 0 tokens based on the `name` and `symbol` provided at time of creation by the Crowdsale organiser.
        KaseiCoin kasei_token = new KaseiCoin(name, symbol, 0); 
        
        /// @dev Store a local copy of the KaseiCoin's token address so that it is all linked and accessible for ease of traceability and auditing.
        kasei_token_address = address(kasei_token);

        /// @dev Create an instance of the `KaseiCoinCrowdsale` contract with an exchange rate of 1 Ether to 1 Token, the wallet address of theCrowdsale organiser and the KaseiCoin contract.
        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, kasei_token);
          
        /// @dev Store a local copy of the KaseiCoinCrowdsale's address so that it is all linked and accessible for ease of traceability and auditing.
        kasei_crowdsale_address = address(kasei_crowdsale);

        /// @dev Assign the `KaseiCoinCrowdsale` contract as a minter of the KaseiCoin token contract
        kasei_token.addMinter(kasei_crowdsale_address);
        
        /// @dev Renounce the `KaseiCoinCrowdsaleDeployer` contract as a minter of the KaseiCoin token contract to avoid any potential for nefarious minting.
        kasei_token.renounceMinter();
    }
}
