pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Deposit is ERC20 {
    address public Admin=0xC20b819365e52f0C1bF4e500b3aD44F517EbA32E;
    mapping(address => bool) public Minter;
    constructor() public ERC20("ERC20Deposit","20D"){}

    function setMinter(address minterAddress,bool isMinter) public{
        require(!Minter[minterAddress],'Already Minter !');
        Minter[minterAddress] = true;
    }

    function isMinter(address minterAddress) public returns(bool){
        return Minter[minterAddress];
    }

    function mint(address toAddress, uint256 amount) public{
        require(amount >0,'Nothing !');
        require(Minter[msg.sender],'Sender is not Minter');
        _mint(toAddress,amount);
    }

    function burn(address fromAddress, uint256 amount) public{
        require(amount >0,'Nothing !');
        require(balanceOf(fromAddress)>=amount,'Too much !');
        require(Minter[msg.sender],'Sender is not Minter');
        _burn(fromAddress,amount);
    }

}