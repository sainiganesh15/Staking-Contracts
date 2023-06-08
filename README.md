# NFT Staking Contracts

This repository contains two Solidity smart contracts that enable NFT staking and token minting based on the duration of the staking period.

## Staking Contracts

Staking contracts are smart contracts that allow users to lock or stake their digital assets, such as tokens or NFTs, for a specific period of time in exchange for certain benefits or rewards. Staking is a popular mechanism in decentralized finance (DeFi) and blockchain ecosystems that incentivizes users to hold and contribute to the network's security and functionality.

## Contracts
### MyNFT
The **MyNFT** contract is an ERC721-compliant contract that represents a non-fungible token (NFT). It extends the `ERC721` contract from the OpenZeppelin library and inherits the `Ownable `contract. The contract allows for the minting of NFTs with unique IDs.

Functions
- `safeMint(address to)`: Mints a new NFT and assigns it to the specified address. The `totalSupply` variable keeps track of the total number of NFTs minted.

## MyToken
The **MyToken** contract is an ERC20-compliant contract that mints tokens based on the duration an NFT is staked. It extends the `ERC20` contract from the OpenZeppelin library and inherits the `ERC721Holder` and `Ownable` contracts.

Variables
- `nft`: Stores the address of the deployed NFT contract.
- `tokenOwnerOf`: A mapping that keeps track of the owner of each staked NFT.
- `tokenStakedAt`: A mapping that records the timestamp when each NFT was staked.
- `EMISSION_RATE`: Determines the rate at which tokens are emitted per day for staking an NFT.
Functions
- `constructor(address _nft)`: Initializes the *MyToken* contract by setting the address of the NFT contract.
- `stake(uint256 tokenId)`: Allows users to stake their NFTs by transferring them to the *MyToken* contract. The ownership and staking timestamp are recorded.
- `calculateTokens(uint256 tokenId)`: Calculates the number of tokens a user can claim based on the duration the NFT was staked.
- `unstake(uint256 tokenId)`: Allows users to unstake their NFTs, minting tokens based on the staking duration and transferring the NFT back to the original owner.
## Usage
1. Deploy the `MyNFT` contract.
2. Deploy the `MyToken` contract, passing the address of the deployed`MyNFT` contract.
3. Approve the `MyToken` contract as an operator for the NFTs by calling the `approve` function on the `MyNFT` contract.
4. Stake NFTs by calling the `stake` function on the `MyToken` contract, passing the ID of the NFT to be staked.
5. Tokens will be minted based on the staking duration and transferred to the staker.
6. Unstake NFTs by calling the `unstake` function on the `MyToken` contract, passing the ID of the NFT to be unstaked.
7. Tokens will be minted and transferred to the caller based on the staking duration, and the NFT will be transferred back to the original owner.


Please note that additional functionalities and error handling may be required based on your specific use case.

## License
This project is licensed under the MIT License. 