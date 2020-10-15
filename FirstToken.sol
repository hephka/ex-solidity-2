// SPDX-License-Identifier: MIT                 r
pragma solidity >=0.6.0;

contract FirstToken {
    mapping(address => bool) public investors;
    mapping(address => uint256) public balances;
    address payable wallet;
    uint token;
    address public owner;
    address public formateur;
    address[] public investor;

    event Purchase(
        address indexed _buyer,
        uint256 _amount
    );

    constructor(address payable _wallet, address _owner) public {
        wallet = _wallet;
        owner = _owner;
        token = 1 ether;
        formateur = 0x57D401B8502bC5CBBaAfD2564236dE4571165051;
    }

    receive() external payable {
        buyToken();
    }

    fallback() external payable {
        wallet.transfer(msg.value);
    }
    
    function setInvestor(address _owner) public {
        require(msg.sender == _owner);
        
    }

    function buyToken() public payable{
        require(msg.value == 1 ether, 'Only ether can use this function.');
        // buy a token
        if (msg.sender == formateur) {
        balances[msg.sender] += 10 * token;
        } else balances[msg.sender] += token;
        // send ether to the wallet
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, 1);
    }
}