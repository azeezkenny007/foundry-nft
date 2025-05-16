// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {CodeConstants} from "../src/CodeConstants.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script, CodeConstants {
    function run() external returns (MoodNft) {
       vm.startBroadcast();
       MoodNft moodNft = new MoodNft(HAPPY_SVG_IMAGE_URI, SAD_SVG_IMAGE_URI);
       vm.stopBroadcast();
       return moodNft;
    }

    function svgToImageUri(string memory svg) public pure returns(string memory){
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
    
}
}