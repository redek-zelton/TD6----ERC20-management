pragma solidity >=0.6.0 <0.8.0;
import './ERC20Claimable.sol';
import './ERC20Deposit.sol';
contract Deposit {

    mapping(address => uint256) public balanceInDeposit;
    uint256 public initBalance =0;
    ERC20Claimable public Claimable;
    ERC20Deposit public ERC20DepositAddress;

    constructor(ERC20Claimable ERC20Address,ERC20Deposit DepositAddress) public
    {
        Claimable = ERC20Address;
        ERC20DepositAddress = DepositAddress; // address
    }

    /****   EXERCICE 2   ****/
    // mettre les tokens dans le contract, après avoir CLAIM
    function claimTokensOnBehalf() public{
        initBalance += Claimable.distributedAmount();
        Claimable.claimTokens(); // tokens go to sender
        Claimable.transfer(address(this),Claimable.distributedAmount()); // token from sender to contract
        balanceInDeposit[msg.sender] +=Claimable.distributedAmount();
    }

    // return the value of Address Balance in this contract, not really the current balance
	function tokensInCustody(address callerAddress) public returns (uint256){
        return balanceInDeposit[callerAddress]; 
    }
    
    function getERC20DepositAddress() public returns(address){
        return address(ERC20DepositAddress);
    }
    /****    EXERCICE 7   ****/
    //Create and deploy an ERC20 (ExerciceSolutionToken) to track user deposit. 
    //This ERC20 should be mintable and mint autorization given to ExerciceSolution.
    //=> A réaliser directement dans le ERC20


    /****    EXERCICE 8   ****/
    function depositTokens(uint256 amountToDeposit)public returns(uint256){
    //Sender send token to Contract Address
    //require(amountToDeposit > 0,'Nothing !');
    Claimable.transferFrom(msg.sender,address(this),amountToDeposit);
    //Contract Address approve Sender's token
    balanceInDeposit[msg.sender]+=amountToDeposit;
    initBalance+=amountToDeposit;
    // donne un nouveau token (mint)
    ERC20DepositAddress.mint(msg.sender,amountToDeposit);
    return amountToDeposit;
    }

    /****   EXERCICE 9   ****/
    function withdrawTokens(uint256 amountTowithdraw)public returns(uint256) {
        //require(balanceInDeposit[msg.sender] >= amountTowithdraw,'Withdraw more than the balance');
        Claimable.transfer(msg.sender, amountTowithdraw); // cannot work here
        initBalance -= amountTowithdraw;
        balanceInDeposit[msg.sender]-=amountTowithdraw;
        // Détruit le nouveau token (burn)
        ERC20DepositAddress.burn(msg.sender,amountTowithdraw);
        return amountTowithdraw;
    }
}