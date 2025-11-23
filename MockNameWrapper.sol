// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockNameWrapper {
    // Simple mock that stores owner of computed node
    mapping(bytes32 => address) public owners;

    function setSubnodeOwner(bytes32 parentNode, string calldata label, address owner, uint32, uint64) external returns (bytes32) {
        bytes32 labelHash = keccak256(bytes(label));
        bytes32 node = keccak256(abi.encodePacked(parentNode, labelHash));
        owners[node] = owner;
        return node;
    }
}
