// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

contract IntegrityGuard {
    address public owner;

    struct File {
        bytes32 fileNameHash;
        bytes32 fileContentHash;
    }

    mapping(address => mapping(bytes32 => File)) public fileRegistry;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function addFile(bytes32 _fileNameHash, bytes32 _fileContentHash) public {
        fileRegistry[msg.sender][_fileNameHash] = File(_fileNameHash, _fileContentHash);
    }

    function getFileHash(address _walletAddress, bytes32 _fileNameHash) public view returns (bytes32) {
        return fileRegistry[_walletAddress][_fileNameHash].fileContentHash;
    }

    function verifyFileHash(address _walletAddress, bytes32 _fileNameHash, bytes32 _inputFileContentHash) public view returns (bool) {
        return fileRegistry[_walletAddress][_fileNameHash].fileContentHash == _inputFileContentHash;
    }
}