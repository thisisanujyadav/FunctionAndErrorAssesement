// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract MyToken {
    

    constructor() {
        owner = msg.sender;
    }

    // public variable
    string public name = "anuj";
    string public symbol = "yadav";
    uint public totalSupply = 0;
    address public owner;

    // emits events
    event Mint(address indexed to, uint amount);
    event Burn(address indexed from, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);

    // errors
    error InsufficientBalance(uint balance, uint withdrawAmount);

    // mapping variable here
    mapping(address => uint) public balances;

    // modifiers
    modifier onlyOwner() {
        assert(msg.sender == owner);
        _;
    }

    // mint function
    function mint(address _address, uint _value) public onlyOwner {
        totalSupply += _value;
        balances[_address] += _value;
        emit Mint(_address, _value);
    }

    // burn function
    function burn(address _address, uint _value) public onlyOwner {
        if (balances[_address] < _value) {
            revert InsufficientBalance({balance: balances[_address],withdrawAmount: _value});
        } else {
            totalSupply -= _value;
            balances[_address] -= _value;
            emit Burn(_address, _value);
        }
    }

    function transfer(address _receiver, uint _value) public {
        require(balances[msg.sender] >= _value, "Account balance must be greater than transferred value");
        balances[msg.sender] -= _value;
        balances[_receiver] += _value;
        emit Transfer(msg.sender, _receiver, _value);
    }
}
