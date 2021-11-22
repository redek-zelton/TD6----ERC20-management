pragma solidity ^0.6.0;
import './ERC20Claimable.sol';
contract Deposit {

    mapping(address => uint256) public balanceInDeposit;
    uint256 public initBalance =0;
    ERC20Claimable Claimable;
    address public Evaluator = 0x384C00Ff43Ed5376F2d7ee814677a15f3e330705;

    constructor(ERC20Claimable ERC20Address) public
    {
        Claimable = ERC20Address;

    }

    /****   EXERCICE 2   ****/
    // mettre les tokens dans le contract, après avoir CLAIM
    function claimTokensOnBehalf() public{
        initBalance += Claimable.distributedAmount();
        Claimable.claimTokens(); // tokens go to sender
        //Claimable.transfer(address(this),Claimable.distributedAmount()); // token from sender to contract
        balanceInDeposit[msg.sender] +=Claimable.distributedAmount();
    }

    // return the value of Address Balance in this contract, not really the current balance
	function tokensInCustody(address callerAddress) public returns (uint256){
        return balanceInDeposit[callerAddress]; 
    }

    /****    EXERCICE 3   ****/
    //WithDraw Token from this contract
    // A REFAIRE
    function withdrawTokens(uint256 amountTowithdraw)public returns(uint256) {
        //require(amountTowithdraw > 0,'Nothing !');
        //require(balanceInDeposit[msg.sender] >= amountTowithdraw,'Withdraw more than the balance');
        Claimable.transfer(msg.sender, amountTowithdraw); // cannot work here
        initBalance -= amountTowithdraw;
        balanceInDeposit[msg.sender]-=amountTowithdraw;
        return amountTowithdraw;
    }

    /****     EXERCICE 4    ****/
    // Use ERC20 function to allow your contract to manipulate your tokens. 
    // On le fera direct sur MyCrypto avec la fonction direct donnée
    /*
    function CanAllowanceHere()public{
        Claimable.allowance(msg.sender,address(this));
    }*/

    /****    EXERCICE 5    ****/
    //Use ERC20 to revoke this authorization.
    // On le fera direct sur MyCrypto avec la fonction direct donnée

    /****   EXERCICE 6   ****/
    //Create a function depositTokens() through which a user can deposit claimableTokens in ExerciceSolution, using transferFrom
    // Take amountToDeposit(100 tokens) from the Evaluator to contract
    function depositTokens(uint256 amountToDeposit)public returns(uint256){
        //Sender send token to Contract Address
        //require(amountToDeposit > 0,'Nothing !');
        //require(Claimable.allowance(msg.sender, address(this)) >= amountToDeposit,'Too Much !');
        Claimable.transferFrom(msg.sender,address(this),amountToDeposit);
        //Contract Address approve Sender's token
        balanceInDeposit[msg.sender]+=amountToDeposit;
        initBalance+=amountToDeposit;
        return amountToDeposit;
    }
}