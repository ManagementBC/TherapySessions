Blockchain and Gen AI-Driven Virtual Therapy Sessions in the Metaverse
This repository contains the source code, smart contracts, and setup instructions for a virtual therapy system built in the Metaverse. It integrates blockchain, decentralized storage, and AI-powered non-player characters (NPCs) to deliver immersive, real-time therapy sessions while ensuring secure access control and privacy through NFTs and IPFS.

📌 Note on Full Project Download
⚠️ Due to size limitations, the complete Unity project with all assets cannot be stored directly on GitHub.
To download the full project (including large Unity assets, builds, and additional resources), please use the following link:
https://drive.google.com/drive/folders/1bJhn1yCrUMsGgnEdCkTFWx6LqvhE-Qbk?usp=drive_link



Please follow the instructions below for setting up the project after downloading the full package.

🔑 Key Features
AI-Driven NPCs: AI-powered virtual therapists deliver personalized mental health support in immersive sessions.

Blockchain Integration: Ethereum smart contracts manage user access and session data securely.

NFT-Based Access Control: Only users holding a valid NFT can join therapy sessions.

Decentralized Storage: Therapy session data is stored immutably on IPFS.

Unity 3D Metaverse Environment: Park-like virtual world designed for relaxation and therapy.

📂 Repository Structure
This GitHub repository is organized into the following main sections:

1️⃣ Unity 3D Projects
Folder 1: WebGL Build (No Voice Recognition)

Unity 3D project for WebGL deployment (without voice recognition).

Suitable for browser-based use.

Folder 2: Local Build with Voice Recognition

Unity 3D project with integrated Microsoft Azure voice recognition.

Designed for local desktop builds only (Azure Speech not supported in WebGL).

2️⃣ Smart Contracts
Located in the Smart Contracts folder:

UAC.sol: Manages NFT minting for access control.

Management.sol: Handles user registration, session data storage, and access verification.

Contracts are written in Solidity, deployed on the Sepolia Ethereum test network, and verified on Etherscan.

⚙️ Installation and Setup
Prerequisites
Unity 3D: Version 2021.3.x or higher recommended.

Ethereum Wallet (e.g., MetaMask): For interacting with the smart contracts.

Microsoft Azure Account: Required for voice recognition in the Local Build version.

Unity 3D Setup
Download the full project from the provided external link.

Unpack the project folders locally.

Open the relevant Unity project in the Unity Editor:

Folder 1 (WebGL Build):

Switch build platform to WebGL.

Build and deploy on the web.

Folder 2 (Local Build):

Configure Microsoft Azure Speech services.

Build and run locally.

Smart Contracts Setup
Navigate to the Smart Contracts folder.

Open the contracts in Remix IDE.

Deploy to the Sepolia Test Network.

Interact with the contracts using MetaMask or another compatible Ethereum wallet.

