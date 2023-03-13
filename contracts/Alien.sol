// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

//import '../helpers/Ownable-05.sol';
//import "@openzeppelin/contracts/ownership/Ownable.sol";


contract AlienCodex {

  bool public contact;
  bytes32[] public codex;

  modifier contacted() {
    assert(contact);
    _;
  }
  
  function make_contact() public {
    contact = true;
  }

  function record(bytes32 _content) contacted public {
    codex.push(_content);
  }

  function retract() contacted public {
    codex.length--;
  }

  function revise(uint i, bytes32 _content) contacted public {
    codex[i] = _content;
  }
}

contract Util {
    bytes32 public inHex;
    uint256 public number;
    uint256 public nToHack;

     
    function getKeccakOfSlot(uint256 slot) public {
        inHex = keccak256(abi.encode(slot));
        number = uint256(inHex);
        nToHack = uint256(0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)-number+1;
    }
}