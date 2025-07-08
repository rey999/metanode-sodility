
// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PaymentToken is IERC20{
    mapping (address => uint256) balances;
    address owner;
    
    constructor(){
        owner = msg.sender;
    }

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() public pure returns (uint256){
        return 0;
    }

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) public  view returns (uint256){
        uint256 balance = balances[account];
        return balance;
    }

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) public returns (bool){
        require(value > 0,"transfer amount must > 0 ");
        //获取当前账户余额
        uint256 fromBalance = balances[msg.sender];
        //转账时，持有金额必须大于转账金额
        require(fromBalance >= value);
        //转账金额 + value
        balances[to] += value;
        //转账人 - value
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address o, address spender) public  pure returns (uint256){
        require(o == spender);
        return 0;
    }

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) public returns (bool){
        //授权是什么意思，是不是合约创建者能让某个地址存在并且有初始金额？
        balances[spender] += value;
        emit Approval(msg.sender, spender, value);
        return false;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) public  returns (bool){
        uint256 fromBalance = balances[from];
        require(fromBalance >= value);
        balances[from]-= value;
        balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }
    function mint(address to, uint256 value)public returns(bool){
        require(msg.sender == owner,"mint must be owner");
        require(value > 0);
        balances[to] += value;
        return true;        
    }
}