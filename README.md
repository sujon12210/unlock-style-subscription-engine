# On-chain Subscription Engine (Unlock-style)

A professional-grade implementation for decentralized monetization. This repository replaces traditional credit card subscriptions with "Key NFTs." Instead of a central database checking user access, your smart contract or frontend checks if the user's wallet holds a valid, non-expired "Key."

## Core Features
* **Time-Bound NFTs:** ERC-721 tokens with a built-in `expirationTimestamp`.
* **Renewable Access:** Logic for users to extend their membership by sending additional funds.
* **Non-Transferable Options:** "Soulbound" settings to prevent users from selling their membership on secondary markets.
* **Flat Architecture:** Single-directory layout for the Lock Factory, Membership Key, and Pricing Module.

## Logic Flow
1. **Create:** A creator deploys a "Lock" contract setting the price (e.g., 0.05 ETH) and duration (e.g., 30 days).
2. **Purchase:** A user buys a "Key." The contract mints an NFT and sets the expiration to `block.timestamp + 30 days`.
3. **Verify:** A website or Discord bot checks `isValid(user)`. If the current time is before the expiration, access is granted.
4. **Expire:** Once the time passes, the NFT remains in the wallet but the `isValid` check returns `false` until renewed.

## Setup
1. `npm install`
2. Deploy `SubscriptionLock.sol`.
