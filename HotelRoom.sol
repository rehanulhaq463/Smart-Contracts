pragma solidity ^0.6.0;

contract HotelRoom {
    enum statuses { Vacant, Occupied }
    statuses currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() public {
        owner = msg.sender;
        currentStatus = statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == statuses.Vacant, "Sorry Currently Occupied.");
        _;  
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided. ");
        _;
    }

    receive() external payable onlyWhileVacant costs(2 ether) {
        currentStatus = statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

}