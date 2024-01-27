// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

/// @author Bruno Ivasic
/// @title KaseiCoinCrowdsale: A smart contract for deploying and managing the KaseiCoin token crowdsale, and allowing investors to purchase KaseiCoin tokens with ether (ETH).

/// @dev Import the KaseiCoin contract from the local repository so it can be used as part of the crowdsale contract
import "./KaseiCoin.sol";

/// @dev Import the Crowdsale and MintedCowdsale libraries from OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


/// @dev Create the KaseiCoinCrowdsale contract composed of the KaseiCoin token classs and inheriting the OpenZeppelin Crowdsale and MintedCrowdsale contract classes.
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    /** @notice
     * Defines the KaseiCoinCrowdsale constructor which is called once only when the smart contract is deployed.
     * The KaseiCoinCrowdsale constructor calls the Crowdsale constructor.
     * @param rate The number of KaseiCoin token units a buyer receives for each wei.
     * @dev `rate` is the conversion between wei and the smallest and indivisible
     * KaseiCoin token unit. As, the KaseiCoin token has been created with a `decimal` of '18' then
     * a `rate` of 1 means the investor would receive 1E-18 (0.000,000,000,000,000,001) of KaseiCoins per wei.
     * @param wallet Address where collected funds will be forwarded to - ie usually the Crowdsale Initiator's wallet.
     * @param token Address of the KaseiCoin token smart contract being sold once deployed.
     */
    constructor(
        uint rate,
        address payable wallet,
        KaseiCoin token
    ) public Crowdsale(rate, wallet, token) {
        /// @dev The KaseiCoinCrowdsale constructor is currently empty as the call to the Crowdsale is done just above as pert of the constructor declaration.
    }
}




/*
contract KaseiCoinCrowdsaleDeployer {
    // Create an `address public` variable called `kasei_token_address`.
    // YOUR CODE HERE!
    // Create an `address public` variable called `kasei_crowdsale_address`.
    // YOUR CODE HERE!

    // Add the constructor.
    constructor(
       // YOUR CODE HERE!
    ) public {
        // Create a new instance of the KaseiCoin contract.
        // YOUR CODE HERE!
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        // YOUR CODE HERE!

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        // YOUR CODE HERE!
            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        // YOUR CODE HERE!
        // Set the `KaseiCoinCrowdsale` contract as a minter
        // YOUR CODE HERE!
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        // YOUR CODE HERE!
    }
}
*/
