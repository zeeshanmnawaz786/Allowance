// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ALLOWNCE{
    
    address public owner;
    
    constructor() {
        owner = msg.sender;
    }

    event allow( string messageAddress, address allowanceAddress, string messageAmount, uint allowanceAmount);
    event depositerInfo(string messageDespoiter, address depositerAddress);
    event withdrawalInfo( string messageAddress, address receiverAddress, string messageAmount,  uint withdrawalAmount);

    mapping (address => uint) public AllowanceRecordMappping;
    modifier onlyOwnerOrAllowance(uint _amount){
        require(AllowanceRecordMappping[msg.sender] >= _amount, "You are not allowed!");
        _;
    }

    function Allow(address receiverAddr, uint _amount) public payable {
        require(msg.sender == owner,"you are not the owner");
        AllowanceRecordMappping[receiverAddr] = _amount;
        emit allow("allowane address", receiverAddr, "allownace amount ", _amount);
    }
    function deposit() public payable{
        msg.value;
        emit depositerInfo("despoiterAddress", msg.sender);
    }
    function withdraw(address receiver, uint _amount) public payable onlyOwnerOrAllowance(_amount){
        require(_amount <=address(this).balance,"Account has not enough money");
        payable(receiver).transfer(_amount);
        emit withdrawalInfo("Withdrawal address", receiver, "withdaw amount ", _amount);
    }
}

