pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";
import {CodeConstants} from "../src/CodeConstants.sol";

contract DeployMoodNftTest is Test, CodeConstants {
    DeployMoodNft public deployer;

    function setUp() external {
        deployer = new DeployMoodNft();
    }

    function testSvgToImageURI() external view {
        string memory actualUri = deployer.svgToImageUri(HAPPY_SVG_IMAGE);
        console.log("actualUri: ", actualUri);
        console.log("HAPPY_SVG_IMAGE_URI: ", HAPPY_SVG_IMAGE_URI);
        assert(keccak256(abi.encodePacked(actualUri)) == keccak256(abi.encodePacked(HAPPY_SVG_IMAGE_URI)));
    }
}
