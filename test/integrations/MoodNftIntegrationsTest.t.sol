// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {CodeConstants} from "../../src/CodeConstants.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MoodNftIntegrationsTest is Test, CodeConstants {
    MoodNft moodNft;
    address public USER = makeAddr("USER");
    DeployMoodNft deployer;
    function setUp() external {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }
 
    function testNfttokenURIIntegration() external {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
    

     function flipHappyMoodToSad() external{
        vm.prank(USER);
        moodNft.mintNft();

        vm.prank(USER); 
        moodNft.flipMood(0);
        assert(keccak256(abi.encodePacked(moodNft.tokenURI(0))) == keccak256(abi.encodePacked(SAD_SVG_IMAGE_URI)));

        
        
    }
}
