// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface INameWrapper {
    function setSubnodeOwner(bytes32 parentNode, string calldata label, address owner, uint32 fuses, uint64 expiry) external returns (bytes32);
}

contract ProductFeedback {
    INameWrapper public nameWrapper;
    bytes32 public constant FEEDBACK_NODE = keccak256("feedback.eth");

    struct Feedback {
        string productEns;
        string userEns;
        string feedbackCid;
        string insightsCid;
        uint256 timestamp;
        address submitter;
    }

    mapping(string => Feedback[]) public productFeedback;
    mapping(string => Feedback[]) public userFeedback;
    mapping(string => bool) public registeredProducts;
    mapping(address => string) public userToEns;
    uint256 public feedbackCount;

    event ProductRegistered(string productEns, address indexed owner, uint256 timestamp);
    event FeedbackSubmitted(string indexed productEns, string indexed userEns, string feedbackCid, string insightsCid, uint256 timestamp);

    constructor(address _nameWrapper) {
        require(_nameWrapper != address(0), "Invalid nameWrapper");
        nameWrapper = INameWrapper(_nameWrapper);
    }

    function registerProduct(string calldata name) external returns (string memory) {
        require(bytes(name).length > 0, "Name cannot be empty");

        string memory productEns = string.concat(name, ".feedback.eth");
        require(!registeredProducts[productEns], "Product already registered");

        // Effects first
        registeredProducts[productEns] = true;

        // Interactions
        nameWrapper.setSubnodeOwner(FEEDBACK_NODE, name, msg.sender, 0, 0);

        emit ProductRegistered(productEns, msg.sender, block.timestamp);
        return productEns;
    }

    function submitFeedback(string calldata productEns, string calldata feedbackCid, string calldata insightsCid) external {
        require(bytes(productEns).length > 0, "productEns required");
        require(bytes(feedbackCid).length > 0, "feedbackCid required");
        require(registeredProducts[productEns], "Product not registered");

        string memory userEns = userToEns[msg.sender];
        if (bytes(userEns).length == 0) {
            string memory userLabel = string.concat("user", _toAsciiString(msg.sender));
            nameWrapper.setSubnodeOwner(FEEDBACK_NODE, userLabel, msg.sender, 0, 0);
            userEns = string.concat(userLabel, ".feedback.eth");
            userToEns[msg.sender] = userEns;
        }

        Feedback memory fb = Feedback({
            productEns: productEns,
            userEns: userEns,
            feedbackCid: feedbackCid,
            insightsCid: insightsCid,
            timestamp: block.timestamp,
            submitter: msg.sender
        });

        productFeedback[productEns].push(fb);
        userFeedback[userEns].push(fb);
        feedbackCount += 1;

        emit FeedbackSubmitted(productEns, userEns, feedbackCid, insightsCid, block.timestamp);
    }

    function getFeedbackByProduct(string calldata productEns) external view returns (Feedback[] memory) {
        return productFeedback[productEns];
    }

    function getFeedbackByUser(string calldata userEns) external view returns (Feedback[] memory) {
        return userFeedback[userEns];
    }

    function isProductRegistered(string calldata productEns) external view returns (bool) {
        return registeredProducts[productEns];
    }

    function getFeedbackCount(string calldata productEns) external view returns (uint256) {
        return productFeedback[productEns].length;
    }

    // Helper: convert address to ascii hex (without 0x)
    function _toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2*i] = _char(hi);
            s[2*i+1] = _char(lo);
        }
        return string(s);
    }

    function _char(bytes1 b) internal pure returns (bytes1 c) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        return bytes1(uint8(b) + 0x57);
    }
}
