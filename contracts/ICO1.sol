// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "./Ownable.sol";

library Balances {
    function move(mapping(address => uint256) storage balances, address from, address to, uint amount) internal {
        require(balances[from] >= amount);
        require(balances[to] + amount >= balances[to]);
        balances[from] -= amount;
        balances[to] += amount;
    }
}


contract TokenIco is Ownable {
    using Address for address payable;
    mapping(address => uint256) private _balances;
    using Balances for *;
    mapping(address => mapping (address => uint256)) private _allowed;
    mapping(address => mapping (address => uint256)) private _allowances;

    event Transfer(address from, address to, uint amount);
    event Approval(address owner, address spender, uint amount);
    event Deposited(address indexed sender, uint256 amount);
    event Withdrew(address indexed recipient, uint256);
    
     constructor(address contractToken_) {
        contractToken_ = msg.sender;
    }

    function transfer(address to, uint amount) public returns (bool success) {
        _balances.move(msg.sender, to, amount);
        emit Transfer(msg.sender, to, amount);
        return true;

    }
    
     receive() external payable {
        _deposit(msg.sender, msg.value);
         //buy(msg.value / _price);
    }
    
    function deposit() external payable {
        _deposit(msg.sender, msg.value);
    }

    function transferFrom(address from, address to, uint amount) public returns (bool success) {
        require(_allowed[from][msg.sender] >= amount);
        _allowed[from][msg.sender] -= amount;
        _balances.move(from, to, amount);
        emit Transfer(from, to, amount);
        return true;
    }

     function withdraw() public {
        uint256 amount = _balances[msg.sender];
        _withdraw(msg.sender, amount);
    }

    function withdraw(uint256 amount) public {
        _withdraw(msg.sender, amount);
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        require(_allowed[msg.sender][spender] == 0, "");
        _allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function buyTokens(uint256 _nbTokens) public payable {
        require(msg.value >= 100 wei, "Minimum price is 100 wei");
        //return _nbTokens;
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return _balances[tokenOwner];
    }
    
    function _deposit(address sender, uint256 amount) private {
        _balances[sender] += amount;
        emit Deposited(sender, amount);
    }
    function _withdraw(address recipient, uint256 amount) private {
        require(_balances[recipient] > 0, "SmartWallet: can not withdraw 0 ether");
        require(_balances[recipient] >= amount, "SmartWallet: Not enough Ether");
        _balances[recipient] -= amount;
        }

     function allowance(address owner_, address spender) public view returns (uint256) {
        return _allowances[owner_][spender];
    }

    function total() public view returns (uint256) {
        return address(this).balance;
    }
}
