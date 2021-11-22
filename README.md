# TD6----ERC20-management

## ex1_claimedPoints()
- it's work

## ex2_claimedFromContract()
- it's work

## ex3_withdrawFromContract()
- it's work

## ex4_approvedExerciceSolution()
- it's work => approuve or increaseAllowance

## ex5_revokedExerciceSolution()
- it's work => decreaseAllowance

## ex6_depositTokens()
```js
/****   EXERCICE 6   ****/
    //Create a function depositTokens() through which a user can deposit claimableTokens in ExerciceSolution, using transferFrom
    // Take amountToDeposit(100 tokens) from the Evaluator to contract
    function depositTokens(uint amountToDeposit)public{
        //Sender send token to Contract Address
        require(amountToDeposit > 0,'Nothing !');
        require(Claimable.allowance(msg.sender, address(this)) >= amountToDeposit,'Too Much !');
        Claimable.transferFrom(msg.sender,address(this),amountToDeposit);
        //Contract Address approve Sender's token
        balanceInDeposit[msg.sender]+=amountToDeposit;
        initBalance+=amountToDeposit;
    }
```
- it's not work on Evaluator
- 1) Go to claimtoken contract => use increaseAllowance or approuve to give the permission of some token: address Deposite  uint value
- =>TxHash [0x7a961bdcb120c08a2883b5fb25c5548c18f0a80909066659fd17261bf0b59776](https://rinkeby.etherscan.io/tx/0x7a961bdcb120c08a2883b5fb25c5548c18f0a80909066659fd17261bf0b59776)
- 2) Go to Deposit contract => use DepositTokens to put your token in this address
- =>TxHash [0xa9baae9e551b4d17ab33854d9327add4bbae5b7fee973bcce345cb5689144d93](https://rinkeby.etherscan.io/tx/0xa9baae9e551b4d17ab33854d9327add4bbae5b7fee973bcce345cb5689144d93)
- 3) Check your balance with balanceInDeposit

====> Finally it's work

## ex7_createERC20()
- it's work

## ex8_depositAndMint()
- it's work
## ex9_withdrawAndBurn()
- it's work
