//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { ECDSA } from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract Test {

    event Signature(bytes32 r, bytes32 s, uint8 v);

    bytes32 public my_hash;
    uint public my_uint;
    address public my_address;
    mapping(address => bytes) public previousSignature;

    bytes32 private constant RIDDLE_3_HASH = 0x3cd65f6089844a3c6409b0acc491ca0071a5672c2ab2a071f197011e0fc66b6a;
    bytes32 private constant RIDDLE_3_ETH_MESSAGE_HASH = 0x20a1626365cea00953c957fd02ddc4963990d404232d4e58acb66f46c59d9887;


    function test (string calldata _string) public {
        my_hash = keccak256(abi.encodePacked(_string));
    }

    function solveChallenge2(string calldata riddleAnswer, bytes memory signature) external {
        bytes32 messageHash = keccak256(abi.encodePacked(riddleAnswer));
        
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
                r := mload(add(signature, 0x20))
                s := mload(add(signature, 0x40))
                v := byte(0, mload(add(signature, 0x60)))
            }

        emit Signature(r,s,v);
        //require(RIDDLE_2_HASH == messageHash, "riddle not solved yet");
        my_address = ECDSA.recover(ECDSA.toEthSignedMessageHash(messageHash), signature);
    }

    function solveChallenge3(
        bytes calldata signature
    ) external {
        // 1 require
        my_address = ECDSA.recover(RIDDLE_3_ETH_MESSAGE_HASH, signature);
    }

    function test1 (uint _number) public {
        if (_number > 10){
            previousSignature[msg.sender] = "0x12";
            return;
        }
        my_uint = previousSignature[msg.sender].length;
        my_address = msg.sender;

    }

}