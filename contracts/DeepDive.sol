// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// ============ External Imports ============

import "@openzeppelin/contracts/access/AccessControl.sol";

/**
 * @title DeepDive
 * @notice This DeepDive contract manages the access and hash lookup for pool and borrower analytics
 * @author Cauris
 */

contract DeepDive is AccessControl {
	address public owner;
	bytes32 public constant WHITELISTED_ROLE = keccak256("WHITELISTED_ROLE");
	bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");
	uint256 public lastUpdate = 0;
	uint256 public enableWhitelist = 1;
	mapping(string => string) public hashFileMap;

	/**
	 * @notice Constructor, provide Admin role to contract deployer, store the public owner variable and apply operator and whitelist roles
	 */
	constructor() AccessControl() {
		owner = msg.sender;
		lastUpdate = block.timestamp;
		_setupRole(DEFAULT_ADMIN_ROLE, owner);
		grantRole(WHITELISTED_ROLE, owner);
		grantRole(OPERATOR_ROLE, owner);
	}

	/**
	 * @notice Flag for enable/disable of whitelist. Must be operator to set.
	 */
	function setEnableWhitelist(uint256 newValue) public {
		require(hasRole(OPERATOR_ROLE, msg.sender), "Not an operator");
		enableWhitelist = newValue;
	}

	/**
	 * @notice Check if wallet address is whitelisted
	 */
	function hasAccess(address forAddress) public view returns (bool) {
		if (enableWhitelist == 0) {
			return true;
		}
		return hasRole(WHITELISTED_ROLE, forAddress);
	}

	/**
	 * @notice Check if wallet address is an operator
	 */
	function hasOperatorAccess(address forAddress) public view returns (bool) {
		return hasRole(OPERATOR_ROLE, forAddress);
	}

	/**
	 * @notice Set data hash for a file type, must be an operator
	 */
	function setDataHash(string memory dataHash, string memory fileType) public {
		require(hasRole(OPERATOR_ROLE, msg.sender), "Not an operator");
		hashFileMap[fileType] = dataHash;
		lastUpdate = block.timestamp;
	}

	/**
	 * @notice Get the data hash for a file type, must be whitelisted or whitelisting disabled
	 */
	function getDataHash(address forAddress, string memory fileType)
		public
		view
		returns (string memory)
	{
		if (enableWhitelist == 0) {
			return hashFileMap[fileType];
		}
		require(hasRole(WHITELISTED_ROLE, forAddress), "Not whitelisted");
		return hashFileMap[fileType];
	}
}
