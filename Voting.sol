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

    struct NumeralPair {
        uint value;
        string symbol;
    }

    NumeralPair[] private numerals;

    constructor(){
        map["I"] = 1;
        map["V"] = 5;
        map["X"] = 10;
        map["L"] = 50;
        map["C"] = 100;
        map["D"] = 500;
        map["M"] = 1000;

        numerals.push(NumeralPair(1000, "M"));
        numerals.push(NumeralPair(900, "CM"));
        numerals.push(NumeralPair(500, "D"));
        numerals.push(NumeralPair(400, "CD"));
        numerals.push(NumeralPair(100, "C"));
        numerals.push(NumeralPair(90, "XC"));
        numerals.push(NumeralPair(50, "L"));
        numerals.push(NumeralPair(40, "XL"));
        numerals.push(NumeralPair(10, "X"));
        numerals.push(NumeralPair(9, "IX"));
        numerals.push(NumeralPair(5, "V"));
        numerals.push(NumeralPair(4, "IV"));
        numerals.push(NumeralPair(1, "I"));

    }
    function intToRoman(uint num) public view returns (string memory) {
        string memory result = "";
        for (uint i = 0; i < numerals.length; i++) {
            while (num >= numerals[i].value) {
                result = string.concat(result, numerals[i].symbol);
                num -= numerals[i].value;
            }
        }
        return result;
    }
    
    
}

contract MergeSortedArrays {
    function mergeArrays(uint[] memory arr1, uint[] memory arr2) public pure returns (uint[] memory) {
        uint len1 = arr1.length;
        uint len2 = arr2.length;
        uint[] memory result = new uint[](len1 + len2);

        uint i = 0; // 指针 for arr1
        uint j = 0; // 指针 for arr2
        uint k = 0; // 指针 for result

        // 合并两个有序数组
        while (i < len1 && j < len2) {
            if (arr1[i] <= arr2[j]) {
                result[k++] = arr1[i++];
            } else {
                result[k++] = arr2[j++];
            }
        }

        // 添加 arr1 剩余元素
        while (i < len1) {
            result[k++] = arr1[i++];
        }

        // 添加 arr2 剩余元素
        while (j < len2) {
            result[k++] = arr2[j++];
        }

        return result;
    }
}



contract BinarySearch {
    // 二分查找函数，返回找到的索引或数组长度表示未找到
    function binarySearch(uint[] memory arr, uint target) public pure returns (int) {
        int left = 0;
        int right = int(arr.length - 1);

        while (left <= right) {
            int mid = left + (right - left) / 2;

            // 检查中间元素是否是目标值
            if (arr[uint(mid)] == target) {
                return mid; // 找到目标值，返回其索引
            }

            // 如果目标值大于中间元素，则忽略左半部分
            if (arr[uint(mid)] < target) {
                left = mid + 1;
            } else {
                // 如果目标值小于中间元素，则忽略右半部分
                right = mid - 1;
            }
        }

        // 如果没有找到目标值，返回-1
        return -1;
    }
}