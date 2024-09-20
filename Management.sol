/**
 *Submitted for verification at Etherscan.io on 2024-08-18
*/

// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.16;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    //function _msgData() internal view virtual returns (bytes calldata) {
    //    return msg.data;
    //}

    //function _contextSuffixLength() internal view virtual returns (uint256) {
    //    return 0;
    //}
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v5.0.0) (access/Ownable.sol)

pragma solidity ^0.8.16;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * The initial owner is set to the address provided by the deployer. This can
 * later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    /**
     * @dev The caller account is not authorized to perform an operation.
     */
    error OwnableUnauthorizedAccount(address account);

    /**
     * @dev The owner is not a valid owner account. (eg. `address(0)`)
     */
    error OwnableInvalidOwner(address owner);

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        if (owner() != _msgSender()) {
            revert OwnableUnauthorizedAccount(_msgSender());
        }
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: IPFSValidator.sol


pragma solidity ^0.8.16;

contract IPFSValidator {
    string constant BASE58_ALPHABET  = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";

    /**
     * @notice Checks if a given string is a valid IPFS hash (CIDv0).
     * @param ipfsHash The IPFS hash to validate.
     * @return A boolean indicating whether the hash is valid.
     */
    function isValidIPFSHash(string memory ipfsHash) public pure returns (bool) {
        bytes memory hashBytes = bytes(ipfsHash);

        // Check the length of the hash (CIDv0 length is 46 characters)
        if (hashBytes.length != 46) {
            return false;
        }

        // Check that the first two characters match "Qm"
        if (hashBytes[0] != 'Q' || hashBytes[1] != 'm') {
            return false;
        }

        // Check if all characters are valid Base58 characters
        for (uint256 i = 0; i < hashBytes.length; i++) {
            if (!_isBase58Character(hashBytes[i])) {
                return false;
            }
        }

        return true;
    }

    /**
     * @notice Checks if a character is a valid Base58 character.
     * @param char The character to check.
     * @return A boolean indicating whether the character is valid.
     */
    function _isBase58Character(bytes1  char) internal pure returns (bool) {
        bytes memory alphabetBytes = bytes(BASE58_ALPHABET);
        for (uint256 i = 0; i < alphabetBytes.length; i++) {
            if (char == alphabetBytes[i]) {
                return true;
            }
        }
        return false;
    }
}
// File: Management.sol



pragma solidity ^0.8.16;



contract Management is Ownable(msg.sender) {
    uint256 public sessionId;
    uint256 public patientCounter;
    IPFSValidator public ipfsValidator;

    struct Patient {
        address patientAddress;
        uint256 patientId;
        bool registered;
    }

    struct Session {
        uint256 sessionId;
        uint256 patientId;
        address patient;
        string ipfsHash;  // IPFS hash of the session data
        uint256 timestamp; // Timestamp when the session was logged
    }

    mapping(address => Patient) public patients;
    mapping(uint256 => Session) public sessions;

    event PatientRegistered(address indexed patient, uint256 patientId);
    event SessionUploaded(uint256 indexed sessionId, uint256 indexed patientId, string ipfsHash);

    constructor(address _ipfsValidator) {
        sessionId = 1;
        patientCounter = 1;
        ipfsValidator = IPFSValidator(_ipfsValidator);
    }

    /**
     * @notice Modifier to allow only registered patients to call a function.
     */
    modifier onlyPatients() {
        require(patients[msg.sender].registered, "Caller is not a registered patient.");
        _;
    }

    /**
     * @notice Registers a patient with a sequential ID.
     * @param patient The address of the patient to register.
     */
    function registerPatient(address patient) external onlyOwner {
        require(!patients[patient].registered, "Patient is already registered.");
        patients[patient] = Patient(patient, patientCounter, true);
        emit PatientRegistered(patient, patientCounter);
        patientCounter++;
    }

    /**
     * @notice Logs a therapy session with associated IPFS hash and other details.
     * @param ipfsHash The IPFS hash of the session data.
     */
    function uploadSession(string memory ipfsHash) public onlyPatients {
        require(ipfsValidator.isValidIPFSHash(ipfsHash), "Invalid IPFS hash provided.");

        uint256 currentPatientId = patients[msg.sender].patientId;
        sessions[sessionId] = Session({
            sessionId: sessionId,
            patientId: currentPatientId,
            patient: msg.sender,
            ipfsHash: ipfsHash,
            timestamp: block.timestamp
        });

        emit SessionUploaded(sessionId, currentPatientId, ipfsHash);
        sessionId++;
    }

    /**
     * @notice Retrieves session details by session ID.
     * @param sessionID The ID of the session.
     * @return The Session struct containing all session details.
     */
    function getSessionDetails(uint256 sessionID) public view returns (Session memory) {
        return sessions[sessionID];
    }

    /**
     * @notice Retrieves patient ID by address.
     * @param patient The address of the patient.
     * @return The patient ID associated with the patient.
     */
    function getPatientId(address patient) public view returns (uint256) {
        require(patients[patient].registered, "Patient is not registered.");
        return patients[patient].patientId;
    }
}
