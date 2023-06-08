// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MyToken is ERC20, ERC721Holder, Ownable {
    IERC721 public nft;
    

    // these mapping are done public so the we can debug the things we need to do and understand what going on below these layers 
    mapping(uint256=>address) public tokenOwnerOf;        // Who is the owner of this NFT actually who can unstake the NFT 
    mapping(uint256=>uint256) public tokenStakedAt;       // At what time the token is staked AT
    


    // Now how long this token was staked at and once it is unstaked we generate that mant tokens and give it back to the user 
    // who staked their nft so let's say we want to emit 50 tokens a day for staking your NFT and However long NFT was staked 
    // we will give you tokens propotional to that 
    // EMISSION_RATE = 50 into 10 to the power decimals because this is an erc20 token so we tell tha last 18 are decimals so 
    // that is how  u can show in the UI but we can't have floats in solidity so we uint fo all those thing 
    // 50 tokens generally mean 50 into 10 to the power of decimals which will be 18 for our case this is how you basically create 50
    // tokens and then 1 day is equal 86400 sec which is what it will be divided by so emission rate so these many token will be released 
    // every to the staker now 
    uint256 public EMISSION_RATE = (50 * 10 ** decimals()) / 1 days;

    constructor(address _nft) ERC20("MyToken", "MTK") {
        nft = IERC721(_nft);
    }

    // function mint(address to, uint256 amount) public onlyOwner {
    //     _mint(to, amount);
    // }



    // one thing we need to understand that we will not able to call the safe transfer from before we apporove the my token as an apporved operator in the nft smart contract 
    // once you mint an nft you will call a method called approve on your nft smart contract and in the operator you will put the tokens address so that token can spend your 
    // nft transfer it to themselves this is how generally done on frontend so when the user is taking first the front end makes a call to the nft smart contract it checks whether the 
    // token smart contract can operate your nfts from the nft smart contract if they can't the front end opens a request basically and ask you to approve the token as an operator for 
    // your nft smart once that happens only then the front end will let you call the my tokens stake function and stake method we have already 
    function stake(uint256 tokenId) external{
        nft.safeTransferFrom(msg.sender, address(this), tokenId);   // if this succeed then we need to know when the token ID arrived and who gave the Token ID
        tokenOwnerOf[tokenId] = msg.sender;
        tokenStakedAt[tokenId] = block.timestamp;
    }

    // calculate the token a user can claim

    function calculateTokens(uint256 tokenId) public view returns(uint256){
        uint256 timeElapsed = block.timestamp - tokenStakedAt[tokenId]; // total time a user has staked it's NFT 
        return timeElapsed * EMISSION_RATE;
    }

    function unstake(uint256 tokenId) external {
        require(tokenOwnerOf[tokenId] == msg.sender, "You are not the original Owner");
        _mint(msg.sender, calculateTokens(tokenId)); // Minting the NFT
        nft.transferFrom(address(this), msg.sender, tokenId);
        delete tokenOwnerOf[tokenId];
        delete tokenStakedAt[tokenId];
    }
}




