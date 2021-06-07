// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "./Ownable.sol";

contract Ico {
    using Address for address payable;

    mapping(address => mapping(address => uint256)) private _allowances;
    mapping (address => uint256) private _balances;
    uint256 private _totalSupply;
    address private _owner;
    address[] private _userAddress;
    Ownable public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(address owner_, uint256 totalSupply_) payable {
        _owner = owner_;
        _totalSupply = totalSupply_;
        _balances[owner_] = totalSupply_;
        emit Transfer(address(0), owner_, totalSupply_);
    }

    

    function addAddress(address _addr) public {
        _userAddress.push(_addr);
    }

    function delLastAddress() public {
        _userAddress.pop();
    }

    function nbAddress() public view returns(uint) {
        return _userAddress.length;
    }

    function buyTokens(uint256 _nbTokens) public payable {
        require(msg.value >= 100 wei, "Minimum price is 100 wei");
        
    }

    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    receive() external payable {
    
    }

    
}
