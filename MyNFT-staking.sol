// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    uint256 public totalSupply;
    constructor() ERC721("MyNFT", "MNFT") {}

    function safeMint(address to) public {
        totalSupply++;
        _safeMint(to, totalSupply);
    }
}

// Things to do
// 1. Create NFT Smart Contract 
// 2. Create Token Smart Contract 
// 3. Add OnERC721Received to Token smart contract 
// 4. Record the timestamps of staking and unstaking to distribute the freshly minted tokens