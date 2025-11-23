# Productooling — dApp MVP

Productooling is a dApp MVP for founders to collect and process product feedback using Web3.


OUR PITCH DECK: https://www.canva.com/design/DAG5ZwBbrTU/0CtZntCbd5hOVyH5EZS3EA/edit?utm_content=DAG5ZwBbrTU&utm_campaign=designshare&utm_medium=link2&utm_source=sharebutton 

LINK VIDEO DEMO: https://drive.google.com/file/d/1sgLqYl7BmeI6AldZ5NFNB7Jtu4N1w691/view?usp=sharing

WEBSITE MVP: https://construct-voice.lovable.app 


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
