// SPDX-License-Identifier: MIT                 r
pragma solidity >=0.6.0;

contract FirstToken {
    mapping(address => bool) public investors;
    mapping(address => uint256) public balances;
    address payable wallet;
    address public owner;
    address public formateur;

    event Purchase(
        address indexed _buyer,
        uint256 _amount
    );

    constructor(address payable _wallet) public {
        wallet = _wallet;
        owner = msg.sender;
        formateur = 0x57D401B8502bC5CBBaAfD2564236dE4571165051;
    }

    receive() external payable {
        buyToken();
    }

    fallback() external payable {
        wallet.transfer(msg.value);
    }
    
    function setInvestor(address _investor) public  {
        require(msg.sender == wallet);
        investors[_investor] = true;
    }

    function buyToken() public payable{
        require(msg.value >= 1 ether, 'Only ether can use this function.');
        // buy a token
        if (investors[msg.sender]) {
        balances[msg.sender] += 10 * msg.value / 1 ether;
        } else balances[msg.sender] += msg.value / 1 ether;
        // send ether to the wallet
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, msg.value / 1 ether);
    }
}