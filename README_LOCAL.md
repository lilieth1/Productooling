Local UI + Contract Quickstart

1) Start a Hardhat node in the  folder:

   cd contracts
   npx hardhat node

2) In another terminal, deploy the contracts to localhost:

   cd contracts
   npm run deploy:local

3) Copy the ProductFeedback address printed by the script and set it as env for the frontend.
   Create  with:

   NEXT_PUBLIC_CONTRACT_ADDRESS=0x...
   NEXT_PUBLIC_SEPOLIA_RPC=http://127.0.0.1:8545

4) Start the frontend:

   cd app
   npm run dev

5) Open the UI at http://localhost:3000

6) To connect MetaMask to the local Hardhat node:
   - In MetaMask, create a new network with RPC URL: http://127.0.0.1:8545
   - Import one of the private keys shown when running  (the script prints prefunded accounts)

