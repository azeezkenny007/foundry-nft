// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/// @author @ Okhamena Azeez
/// @title BasicNft
/// @notice A simple ERC721 NFT contract that allows minting NFTs with custom URIs
/// @dev Inherits from OpenZeppelin's ERC721 implementation
contract BasicNft is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    /// @notice Creates a new BasicNft contract
    /// @dev Initializes the contract with name "Doggie" and symbol "DOG"
    constructor() ERC721("Doggie", "DOG") {
        s_tokenCounter = 0;
    }

    /// @notice Mints a new NFT with the provided token URI
    /// @param tokenUri The URI that points to the NFT's metadata
    /// @dev The token URI should point to a JSON file following the ERC721 metadata standard
    function mintNft(string memory tokenUri) external {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /// @notice Returns the URI for a given token ID
    /// @param _tokenId The ID of the token to get the URI for
    /// @return The URI string associated with the token ID
    function tokenURI(uint256 _tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}
