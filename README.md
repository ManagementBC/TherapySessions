Overview
This repository contains the full source code and smart contracts for a virtual therapy system built in the Metaverse, using blockchain, decentralized storage, and AI-powered non-player characters (NPCs). The project aims to provide users with immersive, real-time therapy sessions powered by AI, ensuring secure access control and privacy through the integration of NFTs and decentralized storage.

Key Features:
AI-Driven NPCs: AI-powered therapists deliver personalized mental health support during virtual therapy sessions.
Blockchain Integration: Smart contracts manage user access and session data storage.
NFT-Based Access Control: Users must hold a valid NFT to access therapy sessions.
Decentralized Storage: Therapy session data is securely stored using IPFS, ensuring immutability and transparency.
Unity 3D Metaverse Environment: Users interact with the system in a park-like Metaverse environment designed for relaxation and immersive therapy experiences.

Repository Structure
This repository is divided into two main sections:

1. Unity 3D Projects
Folder 1: WebGL Build (No Voice Recognition)
This folder contains the Unity 3D code without voice recognition, designed to be built and run using WebGL for deployment on the web.

Folder 2: Local Build with Voice Recognition
This folder includes the same Unity 3D project, but with the addition of Microsoft Azure-based voice recognition functionality. Since Azure's speech recognition is not compatible with WebGL, this version is for local builds only.

2. Smart Contracts
Smart Contracts
The smart contracts for NFT-based access control and session management are located in this folder. These contracts are written in Solidity, deployed on the Sepolia Ethereum test network, and verified on Etherscan. The folder includes:
UAC.sol: Manages the minting of NFTs for users.
Management.sol: Handles user registration, session data storage, and access control.

Installation and Setup

Prerequisites:
Unity 3D: Download Unity (Version 2021.3.x or higher recommended).
Ethereum Wallet (e.g., MetaMask): Required for interacting with the smart contracts.
Microsoft Azure Account: Required for voice recognition in Folder 2 (Local Build).

Unity 3D Setup:
Clone the repository.
Open the respective Unity 3D project folder in the Unity Editor.
For Folder 1 (WebGL Build): Switch the build platform to WebGL and build the project.
For Folder 2 (Local Build): Set up the necessary Microsoft Azure speech services and run the project locally.

Smart Contracts Setup:
Open the Smart Contracts folder.
Deploy the contracts using Remix IDE to the Sepolia Test Network.
Interact with the contracts using MetaMask or another compatible Ethereum wallet.
