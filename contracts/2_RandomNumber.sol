// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract RandomNumber is VRFConsumerBaseV2 {

    uint256 private constant ROLL_IN_PROGRESS = 42;

    VRFCoordinatorV2Interface COORDINATOR;

    uint64 s_subscriptionId = 7420;
    address vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
    bytes32 s_keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
    uint32 callbackGasLimit = 40000;
    uint16 requestConfirmations = 3;
    uint32 numWords = 1;
    address owner;
    uint256 public randomResult;

    constructor() VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        owner = msg.sender;
    }
   
    function getRandomNumber() public returns (uint256 requestId) {
        requestId = COORDINATOR.requestRandomWords(
            s_keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        randomResult = (randomWords[0] % 10) + 1;
    }
    
}
