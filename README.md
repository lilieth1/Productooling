# Productooling
Growing business and builders with real feedback from the market 
# Productooling — dApp MVP

Productooling is a dApp MVP for founders to collect and process product feedback using Web3.

Main structure:

- `contracts/` — Smart contracts in Solidity, Hardhat scripts, and tests.

- `app/` — Next.js 14 frontend with components and services.

Requirements: Node 18+, npm/yarn, MetaMask for the frontend.

Quick start (contracts):

```bash
cd contracts
npm install
npx hardhat compile
npm test
```

Quick start (frontend):

```bash
cd app
npm install
npm run dev
```

Environment variables: copy `.env.example` → `.env` and populate the keys.

Notes:
- The `filecoin.service` service is an in-memory mock for development.

- `ai.service` tries to call 0G; if there is no key, use a keyword fallback.
- ENS interactions in tests use `MockNameWrapper`.
# Productoling
Growing business and builders with real feedback from the market
