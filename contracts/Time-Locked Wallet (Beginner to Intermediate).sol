// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title Time-Locked Wallet
 * @dev A smart contract that allows users to deposit funds with time-based withdrawal restrictions
 * @author Your Name
 */
contract Project {
    // State variables
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public unlockTime;
    
    // Events
    event Deposit(address indexed user, uint256 amount, uint256 unlockTime);
    event Withdrawal(address indexed user, uint256 amount);
    event EmergencyWithdrawal(address indexed user, uint256 amount, uint256 penalty);
    
    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    modifier hasBalance() {
        require(balances[msg.sender] > 0, "No balance to withdraw");
        _;
    }
    
    // Constructor
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev Core Function 1: Deposit funds with time lock
     * @param _lockDuration Duration in seconds for which funds will be locked
     */
    function depositWithTimeLock(uint256 _lockDuration) external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        require(_lockDuration > 0, "Lock duration must be greater than 0");
        require(_lockDuration <= 365 days, "Lock duration cannot exceed 1 year");
        
        // If user already has a balance, add to existing balance and extend lock time if new lock is longer
        if (balances[msg.sender] > 0) {
            balances[msg.sender] += msg.value;
            uint256 newUnlockTime = block.timestamp + _lockDuration;
            if (newUnlockTime > unlockTime[msg.sender]) {
                unlockTime[msg.sender] = newUnlockTime;
            }
        } else {
            balances[msg.sender] = msg.value;
            unlockTime[msg.sender] = block.timestamp + _lockDuration;
        }
        
        emit Deposit(msg.sender, msg.value, unlockTime[msg.sender]);
    }
    
    /**
     * @dev Core Function 2: Withdraw funds after time lock expires
     */
    function withdraw() external hasBalance {
        require(block.timestamp >= unlockTime[msg.sender], "Funds are still locked");
        
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        unlockTime[msg.sender] = 0;
        
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdrawal failed");
        
        emit Withdrawal(msg.sender, amount);
    }
    
    /**
     * @dev Core Function 3: Emergency withdrawal with penalty
     * Allows users to withdraw before unlock time but with a 10% penalty
     */
    function emergencyWithdraw() external hasBalance {
        require(block.timestamp < unlockTime[msg.sender], "Use regular withdraw - lock period has expired");
        
        uint256 totalAmount = balances[msg.sender];
        uint256 penalty = totalAmount / 10; // 10% penalty
        uint256 withdrawAmount = totalAmount - penalty;
        
        balances[msg.sender] = 0;
        unlockTime[msg.sender] = 0;
        
        // Send penalty to contract owner
        if (penalty > 0) {
            (bool penaltySuccess, ) = payable(owner).call{value: penalty}("");
            require(penaltySuccess, "Penalty transfer failed");
        }
        
        // Send remaining amount to user
        (bool success, ) = payable(msg.sender).call{value: withdrawAmount}("");
        require(success, "Emergency withdrawal failed");
        
        emit EmergencyWithdrawal(msg.sender, withdrawAmount, penalty);
    }
    
    // View functions
    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }
    
    function getUnlockTime(address _user) external view returns (uint256) {
        return unlockTime[_user];
    }
    
    function getTimeRemaining(address _user) external view returns (uint256) {
        if (block.timestamp >= unlockTime[_user]) {
            return 0;
        }
        return unlockTime[_user] - block.timestamp;
    }
    
    function isUnlocked(address _user) external view returns (bool) {
        return block.timestamp >= unlockTime[_user];
    }
    
    // Owner functions
    function getContractBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }
    
    // Fallback function to reject direct transfers
    receive() external payable {
        revert("Use depositWithTimeLock function to deposit funds");
    }
}
