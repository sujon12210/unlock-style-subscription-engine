// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SubscriptionLock
 * @dev Manages time-limited NFT access keys.
 */
contract SubscriptionLock is ERC721, Ownable {
    uint256 public nextKeyId;
    uint256 public expirationDuration; // e.g., 30 days in seconds
    uint256 public keyPrice;

    mapping(uint256 => uint256) public keyExpiration;

    event KeyPurchased(address indexed buyer, uint256 tokenId, uint256 expiration);

    constructor(
        string memory _name, 
        string memory _symbol, 
        uint256 _price, 
        uint256 _duration
    ) ERC721(_name, _symbol) Ownable(msg.sender) {
        keyPrice = _price;
        expirationDuration = _duration;
    }

    /**
     * @dev Purchase a new membership key or extend an existing one.
     */
    function purchaseKey() external payable {
        require(msg.value >= keyPrice, "Insufficient payment");
        
        uint256 tokenId = nextKeyId++;
        _safeMint(msg.sender, tokenId);
        
        keyExpiration[tokenId] = block.timestamp + expirationDuration;
        
        emit KeyPurchased(msg.sender, tokenId, keyExpiration[tokenId]);
    }

    /**
     * @dev Checks if a specific token is still valid.
     */
    function getHasValidKey(uint256 _tokenId) public view returns (bool) {
        return keyExpiration[_tokenId] >= block.timestamp;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
