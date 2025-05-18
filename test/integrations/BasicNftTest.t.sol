// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    string public constant DOG_TOKEN_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    address public USER = makeAddr("USER");
    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() external view {
        string memory name = basicNft.name();
        string memory expectedName = "Doggie";
        assert(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked(expectedName)));
    }

    function testSymbolIsCorrect() external view {
        string memory symbol = basicNft.symbol();
        string memory expectedSymbol = "DOG";
        assert(keccak256(abi.encodePacked(symbol)) == keccak256(abi.encodePacked(expectedSymbol)));
    }

    function testIfUserCanMintNft() external {
        vm.prank(USER);
        basicNft.mintNft(DOG_TOKEN_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(DOG_TOKEN_URI)));
    }
}
