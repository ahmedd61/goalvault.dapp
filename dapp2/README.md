# GoalVault dApp (MG3012 Assignment 2)

A savings-vault dApp: a Solidity contract on **Sepolia** plus a single-page HTML/CSS/JS frontend (ethers.js v6) connected through MetaMask. You set a goal in ETH, deposit toward it, and can only withdraw once your savings reach the goal.

- **Contract address (Sepolia):** `0x145d0d1124c835016327278675fC3cc83e8F79DB`
- **Etherscan:** https://sepolia.etherscan.io/address/0x145d0d1124c835016327278675fC3cc83e8F79DB
- **Author:** Ahmed, BSFT 5th Semester, FAST-NUCES

## Contract functions
| Function | Type | Purpose |
|---|---|---|
| `setGoal(goalWei)` | write | Set or change your savings goal |
| `deposit()` | write (payable) | Add ETH to your vault (goal must be set) |
| `withdraw()` | write | Withdraw everything once balance >= goal |
| `getVault(user)` | read | Balance, goal, and whether you can withdraw |
| `totalLocked()` | read | Total ETH held by the contract |

## Setup
1. Install MetaMask, switch to **Sepolia**, get test ETH from a faucet.
2. In [Remix](https://remix.ethereum.org) create `SmartContract.sol`, paste the code, compile (Solidity 0.8.20+).
3. *Deploy & Run* → Environment **Injected Provider – MetaMask** → Deploy → confirm.
4. Paste the address into `CONTRACT_ADDRESS` in `index.html` and into this README.
5. Open `index.html` (or `npx serve .`) → Connect MetaMask → Set goal → Deposit → Withdraw.
6. (Bonus) Verify the contract on Sepolia Etherscan.

## Screenshots
`screenshots/1_deployment.png`, `2_connected.png`, `3_transaction.png`

## Tech
Solidity ^0.8.20 · Remix · MetaMask · ethers.js 6.13 · HTML/CSS/JS
