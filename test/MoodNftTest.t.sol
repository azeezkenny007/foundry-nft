// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {CodeConstants} from "../src/CodeConstants.sol";

contract MoodNftTest is Test, CodeConstants {
    MoodNft moodNft;
    address public USER = makeAddr("USER");

    function setUp() external {
        moodNft = new MoodNft(HAPPY_SVG_IMAGE_URI, SAD_SVG_IMAGE_URI);
    }

    function testNfttokenURI() external {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}
