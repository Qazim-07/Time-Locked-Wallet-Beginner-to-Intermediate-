# Time-Locked Wallet

## Project Description

The Time-Locked Wallet is a smart contract that enables users to deposit cryptocurrency with time-based withdrawal restrictions. Users can lock their funds for a specified duration, ensuring they cannot access their money until the lock period expires. This project serves as a decentralized savings mechanism or commitment device, helping users avoid impulsive spending and encouraging long-term financial planning.

The contract includes an emergency withdrawal feature that allows users to access their funds before the lock expires, but with a penalty fee. This provides flexibility while still maintaining the core time-lock functionality.

## Project Vision

Our vision is to create a trustless, decentralized financial tool that promotes disciplined saving habits and long-term wealth accumulation. By leveraging blockchain technology, we aim to provide users with a secure, transparent, and immutable way to commit to their financial goals without relying on traditional banking institutions.

The Time-Locked Wallet serves as a foundation for more advanced DeFi applications and demonstrates how smart contracts can be used to create innovative financial products that benefit individual users and the broader ecosystem.

## Key Features

### Core Functionality
- **Time-Locked Deposits**: Users can deposit ETH with a custom lock duration (up to 1 year)
- **Secure Withdrawals**: Funds can only be withdrawn after the specified lock period expires
- **Emergency Withdrawals**: Users can access funds early with a 10% penalty fee

### Security Features
- **Owner Controls**: Contract owner can monitor contract balance and receive penalty fees
- **Balance Tracking**: Individual user balances and unlock times are securely stored
- **Input Validation**: Comprehensive checks for deposit amounts and lock durations

### User-Friendly Features
- **Multiple View Functions**: Check balance, unlock time, and remaining lock duration
- **Event Logging**: All deposits and withdrawals are logged for transparency
- **Flexible Lock Extensions**: Additional deposits can extend existing lock periods

### Technical Features
- **Gas Optimized**: Efficient storage and function implementations
- **Solidity Best Practices**: Proper use of modifiers, events, and error handling
- **Upgrade Safe**: Clean contract structure allows for future enhancements

## Future Scope

### Enhanced Features
- **Multiple Token Support**: Extend beyond ETH to support ERC-20 tokens
- **Flexible Penalty Structure**: Implement sliding penalty rates based on remaining lock time
- **Interest Earning**: Integrate with DeFi protocols to earn yield on locked funds
- **NFT Certificates**: Issue NFTs as proof of locked deposits

### Advanced Functionality
- **Multi-Signature Support**: Allow multiple parties to control withdrawal permissions
- **Scheduled Withdrawals**: Enable automatic periodic withdrawals after unlock
- **Social Recovery**: Implement recovery mechanisms for lost private keys
- **Governance Features**: Allow token holders to vote on contract parameters

### Integration Possibilities
- **DeFi Ecosystem**: Connect with lending protocols, DEXs, and yield farming
- **Mobile Applications**: Develop user-friendly mobile interfaces
- **Cross-Chain Support**: Expand to other blockchain networks
- **Institutional Features**: Add features for corporate treasury management

### Compliance and Security
- **Audit Integration**: Implement formal verification and security audits
- **Regulatory Compliance**: Add KYC/AML features for institutional adoption
- **Insurance Integration**: Partner with DeFi insurance protocols
- **Advanced Analytics**: Provide detailed financial reporting and analytics

---

## Getting Started

### Prerequisites
- Node.js and npm installed
- Hardhat or Truffle development environment
- MetaMask or similar Web3 wallet

### Installation
1. Clone the repository
2. Install dependencies: `npm install`
3. Compile contracts: `npx hardhat compile`
4. Run tests: `npx hardhat test`
5. Deploy: `npx hardhat run scripts/deploy.js`

### Usage
1. Connect your Web3 wallet
2. Call `depositWithTimeLock()` with desired lock duration
3. Wait for lock period to expire
4. Call `withdraw()` to retrieve your funds

---

**License**: MIT  
**Version**: 1.0.0  
**Solidity Version**: ^0.8.19

contract Address: 0xbd36aad33647fc6845ec849becb6f08e821bc4c5

![image](https://github.com/user-attachments/assets/d76e885e-6d1c-4f8c-bebd-7b6e56255e90)
