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

    function RevertString(string memory str) public pure returns(string memory) {
        bytes memory stringBytes = bytes(str);
        if (stringBytes.length == 0){
            return str;
        }
        bytes memory result = new bytes(stringBytes.length);
        for(uint256 i = 0;i < stringBytes.length;i++){
            result[i] = stringBytes[stringBytes.length - 1 - i];
        }
        return string(result);
    }
    mapping(bytes1=>uint256)public map ;
    constructor(){
        map["I"] = 1;
        map["V"] = 5;
        map["X"] = 10;
        map["L"] = 50;
        map["C"] = 100;
        map["D"] = 500;
        map["M"] = 1000;
    }
    function romanToInt(string memory s) public view returns(uint) {
        
        bytes memory stringBytes = bytes(s);
        uint total = 0;

        for (uint i = 0; i < stringBytes.length; i++) {
            uint value = map[stringBytes[i]];

            // 如果不是最后一个字符，并且当前字符值小于后一个字符值，则减去当前值
            if (i + 1 < stringBytes.length && map[stringBytes[i]] < map[stringBytes[i + 1]]) {
                total -= value;
            } else {
                total += value;
            }
        }

        return total;
    }
    
    
}