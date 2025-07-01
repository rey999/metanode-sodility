// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

contract Voting {
    
    mapping(string => int256) public senderMap;
    string[] public keys;

    function vote (string memory name) public returns(bool){
        if(senderMap[name] == 0){
            keys.push(name);
        }
        senderMap[name] += 1;
        return true;
    }

    function getVotes(string memory name) public view returns (int256) {
        return senderMap[name];
    }

    function resetVotes() public {
        for (uint256 i = 0; i < keys.length ; i++) 
        {
            delete senderMap[keys[i]];
        }
        delete keys;
    }

    
}