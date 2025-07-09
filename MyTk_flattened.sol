
// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

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
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: MyTk.sol


pragma solidity >= 0.8;


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