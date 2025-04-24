// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

    uint256 number;
    address owner;

    modifier onlyOwner () {
        require(msg.sender == owner, "only owner");
        _;
    }

    constructor() {
        owner = msg.sender; // Quem executou a transação 
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public onlyOwner{
        number = num;
    }

    function changeOwner(address newOwner) public onlyOwner{
        owner = newOwner;
    }

    function pay() public payable {} 

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }

    function getOwner() public view returns(address) {
        return owner;
    }

    function getBalance() public view returns(uint256 bal) {
        bal = address(this).balance;
    }
}