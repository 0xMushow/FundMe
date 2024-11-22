# FundMe Project

A smart contract project designed for decentralized funding management using Chainlink oracles for price conversions. This repository includes a core `FundMe` contract, a `PriceConverter` library for ETH/USD price conversion, and Foundry scripts for deployment and interaction.

## Built With

This project has been built while following along the **Cyfrin Updraft Foundry** courses, which provide hands-on lessons in smart contract development, security, and deployment using Foundry. The courses have helped structure and guide the development of this project.


---

## Features

1. **Funding System**: Accepts ETH contributions with a minimum value in USD using Chainlink price feeds.
2. **Secure Withdrawals**: Only the contract owner can withdraw funds.
3. **Gas Optimization**: Includes `cheaperWithdraw` function for efficient gas usage.
4. **Chainlink Integration**: Leverages Chainlink price feeds for real-time ETH/USD conversion.
5. **Fallback Functionality**: Automatically triggers funding for direct ETH transfers.
6. **Multi-Network Support**: Includes support for Sepolia, Mainnet, and local Anvil test environments.

---

## Contracts Overview

### FundMe
A contract that manages ETH contributions and supports secure withdrawals.  
Key Functions:
- `fund()`: Accept ETH contributions.
- `withdraw()`: Allow the owner to withdraw all funds.
- `cheaperWithdraw()`: Optimized withdrawal function.
- View functions for retrieving funder information and contract state.

### PriceConverter (Library)  
Performs ETH/USD conversion using Chainlink price feeds.

Key Functions:
- `getPrice()`: Fetches the current ETH/USD price.
- `getConversionRate(uint256)`: Converts a given ETH amount to USD.

---

## Deployment

### Requirements
- Foundry
- Chainlink Contracts (latest Brownie version)
- Cyfrin Foundry-DevOps tools

### Steps
1. Clone the repository:

```bash
git clone https://github.com/your-repo/fundme.git
cd fundme
```

2. Install dependencies:

```bash
make install
```

3. Deploy the `FundMe` contract using Foundry's script:
 
```bash
make deploy
```

---

### Required Environment Variables

Create a `.env` file at the root of the project and add the following variables:

1. **Sepolia Configuration:**
   - `SEPOLIA_PRIVATE_KEY`: Your private key for the Sepolia network.  
     To encrypt/encode your private key for security, use:  
     `cast wallet import defaultKey --interactive`  
     Paste your private key when prompted.
   - `SEPOLIA_RPC_URL`: The RPC endpoint for the Sepolia network (e.g., from Alchemy or Infura).
   - `ETHERSCAN_API_KEY`: Your API key for verifying contracts on Etherscan.
   - `ACCOUNT`: The name of the wallet imported with `cast wallet import defaultKey`.

2. **zkSync Configuration:**
   - `ZKSYNC_PRIVATE_KEY`: Your private key for the zkSync network.
   - `ZKSYNC_RPC_URL`: The RPC endpoint for the zkSync network (e.g., from zkSync's official endpoints).

### Example `.env` file

Create a `.env` file with the following content:

```
SEPOLIA_PRIVATE_KEY=your_sepolia_private_key_here
SEPOLIA_RPC_URL=https://your_sepolia_rpc_url_here
ETHERSCAN_API_KEY=your_etherscan_api_key_here
ACCOUNT=defaultKey

ZKSYNC_PRIVATE_KEY=your_zksync_private_key_here
ZKSYNC_RPC_URL=https://your_zksync_rpc_url_here
```

### Sourcing the `.env` File

To ensure the environment variables are correctly loaded, source the `.env` file before running any commands:

```bash
source .env
```

This will make the environment variables available to your scripts and commands.

---

## Testing

Run the test suite using Foundry:

```bash
forge test
```

---

## Configuration

The `HelperConfig` script dynamically sets the price feed address based on the active network.  
Supported Networks:
- Sepolia
- Mainnet
- Local Anvil (with mock price feeds)

---

## Usage

### Funding the Contract

1. Deploy the contract

`make deploy` or `make deploy-sepolia` or if you're fancying ZK, `make deploy-zk` or `make deploy-zk-sepolia`

2. Send ETH to the contract:
   
`make fund` or `make fund-sepolia`


### Withdrawing Funds
1. Use the `withdraw()` function as the owner:

```bash
make withdraw()
```

---

## Key Considerations
- The `MINIMUM_USD` is hardcoded to 5 USD (equivalent in ETH at runtime).
- Only the owner can withdraw funds.
- The `cheaperWithdraw()` function is more gas-efficient for clearing funder data.

---

## Resources
- Chainlink Documentation: https://docs.chain.link/
- Foundry Documentation: https://book.getfoundry.sh/
- Solidity Documentation: https://docs.soliditylang.org/
- Cyfrin Updraft: https://updraft.cyfrin.io/courses