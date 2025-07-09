// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BeggingContract{
    address public owner;
    uint256 public donationStart;
    uint256 public donationEnd;
    mapping(address => uint) public donations;

    address[] public donors;

    event Donation(address indexed donor,uint256 amount);
    event Withdraw(address indexed owner,uint256 amount);

    modifier onlyOwner(){
        require(msg.sender == owner,"Not contract owner");
        _;
    }

    modifier onlyDuringDonation(){
        require(block.timestamp >= donationStart && block.timestamp <= donationEnd,"Not during donating");
        _;
    }

    constructor(uint256 _start,uint256 _end){
        require(_start <= _end,"Start should be less than end");
        owner = msg.sender;
        donationStart = _start;
        donationEnd = _end;
    }

    //施舍
    function donate() public payable onlyDuringDonation{
        require(msg.value > 0,"Not enough money for donating");
        if(donations[msg.sender] == 0){
            donors.push(msg.sender);
        }
        donations[msg.sender] += msg.value;
        emit Donation(msg.sender,msg.value);
    }

//提取所有钱
    function withdraw() public onlyOwner{
        uint256 balance = address(this).balance;
        require(balance >  0,"no funds to withdraw");

        payable(owner).transfer(balance);
        emit Withdraw(owner, balance);
    }

    function getTopDonors() public view returns(address[3] memory){
        uint256[3] memory topAmounts;
        address[3] memory topDonors;
        for(uint256 i = 0;i< donors.length;i++){
            uint256 amount = donations[donors[i]];
            if (amount > topAmounts[0]) {
                // 推动排名
                topAmounts[2] = topAmounts[1];
                topDonors[2] = topDonors[1];
                topAmounts[1] = topAmounts[0];
                topDonors[1] = topDonors[0];
                topAmounts[0] = amount;
                topDonors[0] = donors[i];
            } else if (amount > topAmounts[1]) {
                topAmounts[2] = topAmounts[1];
                topDonors[2] = topDonors[1];
                topAmounts[1] = amount;
                topDonors[1] = donors[i];
            } else if (amount > topAmounts[2]) {
                topAmounts[2] = amount;
                topDonors[2] = donors[i];
            }
        }
        return topDonors;
    }

    function donationAllowed() public view returns(bool){
        return block.timestamp >= donationStart && block.timestamp <= donationEnd;
    }

    receive() external payable { 
        donate();
    }
}