// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title GoalVault - a personal savings vault (MG3012 Assignment 2)
/// @notice Set a savings goal in ETH, deposit toward it, and withdraw only once the goal is reached.
contract GoalVault {
    struct Vault {
        uint256 balance; // wei saved
        uint256 goal;    // wei target
    }

    mapping(address => Vault) private vaults;
    uint256 private lockedTotal;

    event GoalSet(address indexed user, uint256 goal);
    event Deposited(address indexed user, uint256 amount, uint256 newBalance);
    event Withdrawn(address indexed user, uint256 amount);

    // ---------- WRITE functions ----------

    /// @notice Set or change your savings goal (in wei).
    function setGoal(uint256 goalWei) external {
        require(goalWei > 0, "Goal must be > 0");
        vaults[msg.sender].goal = goalWei;
        emit GoalSet(msg.sender, goalWei);
    }

    /// @notice Deposit ETH into your vault.
    function deposit() external payable {
        require(msg.value > 0, "Send some ETH");
        require(vaults[msg.sender].goal > 0, "Set a goal first");
        vaults[msg.sender].balance += msg.value;
        lockedTotal += msg.value;
        emit Deposited(msg.sender, msg.value, vaults[msg.sender].balance);
    }

    /// @notice Withdraw everything, allowed only when balance >= goal.
    function withdraw() external {
        Vault storage v = vaults[msg.sender];
        require(v.balance > 0, "Nothing to withdraw");
        require(v.balance >= v.goal, "Goal not reached yet");
        uint256 amount = v.balance;
        v.balance = 0;
        v.goal = 0;
        lockedTotal -= amount;
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Transfer failed");
        emit Withdrawn(msg.sender, amount);
    }

    // ---------- READ functions ----------

    function getVault(address user) external view returns (uint256 balance, uint256 goal, bool canWithdraw) {
        Vault storage v = vaults[user];
        return (v.balance, v.goal, v.balance > 0 && v.balance >= v.goal);
    }

    function totalLocked() external view returns (uint256) {
        return lockedTotal;
    }
}
