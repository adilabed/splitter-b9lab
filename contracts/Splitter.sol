pragma solidity ^0.5.0;

///@title A splitter smart contract
///@author Adil Abed
///@notice This is an educational assignment.Smart contract might contain severe security bugs



import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Splitter {
    using SafeMath for uint256;

    address payable public owner;
    mapping (address => uint) public balances;

    constructor() payable public {
        owner = msg.sender;
    }
    //  Alice use this function to split the sent Amount between futur recipients
    //No direct transfers of ether are made. Balances are updated. Bob & Carol can claim the ether via the withdraw function.
    function SplitInHalf(address bob, address carol) public payable {
        require(bob != address(0x0) && carol != address(0x0), "To avoid wasting some precious ether");
        require(msg.value > 0, "Avoiding trouble");

        balances[carol].add(msg.value.div(2));
        balances[bob].add(msg.value.div(2));
    }

    // Bob & Carol can use this function to claim their payments
    function withdraw() public  {
        uint withdrawnAmount = balances[msg.sender];

        balances[msg.sender] = 0;
        msg.sender.transfer(withdrawnAmount);

    }

    // Kill Switch
    function kill() public {
        if(msg.sender == owner) selfdestruct(owner);
    }


}
