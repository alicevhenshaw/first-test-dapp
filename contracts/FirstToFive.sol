pragma solidity ^0.4.24;

contract FirstToFive {
    mapping (address => uint256) tally;

    event Tally(address indexed _from, uint256 _value);

    bool gameIsOver = false;

    constructor() public {}

    function addTally() public payable returns(bool sufficient) {
        require(!gameIsOver, "Game is over, sorry!");

        if (tally[msg.sender] == 0) {
            require(msg.value > 0, "You must send money to join the game");
		}

        tally[msg.sender] +=1;

        if (tally[msg.sender] == 5) {
            gameIsOver = true;
            msg.sender.transfer(address(this).balance);
		}

        emit Tally(msg.sender, tally[msg.sender]);
        return true;
    }

    function getTally(address addr) public view returns(uint256){
        return tally[addr];
    }

    function isGameOver() public view returns(bool) {
        return gameIsOver;
    }

}
