// SPDX-License-Identifier: MIT
pragma solidity >= 0.8;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyTk is IERC20 {
    string public name = "MyTk";
    string public symbol = "MTK";
    uint public deciamls = 18;
    uint256 public totalSupply;

    address public owner ;
    mapping(address=>uint256) private balances;
    mapping(address=>mapping(address=>uint256)) private allowances;

    modifier onlyOwner(){
        require(msg.sender == owner,"not contract owner");
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    //查询账户余额
    function balanceOf(address account) public view returns(uint256){
        return balances[account];
    }

    //转账
    function transfer(address to, uint256 amount) public virtual override onlyOwner() returns (bool){
        require(balances[msg.sender] >= amount,"Insufficient balance");
        _transfer(msg.sender,to,amount);
        return true;
    }

    //额度授权
    function approve(address spender,uint256 amount) public returns(bool){
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender,spender,amount);
        return true;
    }

    //授权转账
    function transferFrom(address from,address to,uint256 amount) public returns(bool){
        require(allowances[from][msg.sender] >= amount,"Insufficient allowance");
        require(balances[from] >= amount,"Balance too low");
        allowances[from][msg.sender] -= amount;
        _transfer(from,to,amount);
        return true;
    }

    //查询授权
    function allowance(address _owner,address spender) public view returns(uint256){
        return allowances[_owner][spender];
    }

    //发币
    function mint(address to, uint256 amount) public onlyOwner{
        require(to != address(0),"Invalid address");
        totalSupply += amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to,amount);
    }

    //转账逻辑
    function _transfer(address from,address to,uint256 amount) internal{
        require(to != address(0),"Invalid address");
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to,amount);
    }



}