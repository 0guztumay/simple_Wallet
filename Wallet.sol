// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Wallet{
    uint256 public walletAmount;
    address userAddress;
    string accountName;

    struct Users{
        address accountAddress;
        uint256 accountAmount;
    }

    mapping(string => Users) public userInfos;

    receive()external payable{
        walletAmount += address(this).balance;
    }

    function createAccount(string memory _accountName ,address payable _accountAddress)public{
        accountName = _accountName;
        userAddress = _accountAddress;
        userInfos[accountName] = Users(_accountAddress, 0);
    }

    function sendEther(address payable _address, uint _amount)public{
        require(_address != userAddress, "These Are Same Accounts!" );
        _address.transfer(_amount);
        walletAmount -= _amount;
        userInfos[accountName] = Users(userAddress, _amount);
    }
}