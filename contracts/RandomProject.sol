// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract Randomness is VRFConsumerBaseV2, ConfirmedOwner {
    event RequestSent(uint256 requestId, uint32 numWords);
    event RequestFulfilled(uint256 requestId, uint256[] randomWords);

    struct RequestStatus {
        bool fulfilled; // whether the request has been successfully fulfilled
        bool exists; // whether a requestId exists
        uint256[] randomWords;
    }
    mapping(uint256 => RequestStatus)
        public s_requests; /* requestId --> requestStatus */
    VRFCoordinatorV2Interface COORDINATOR;

    bytes32 internal keyHash;
    uint256 internal fee;
    uint256 public randomResult;

    string[] public groupOfProjects;

    // Your subscription ID.
    uint64 s_subscriptionId;

    // past requests Id.
    uint256[] public requestIds;
    uint256 public lastRequestId;

    constructor() public {}

    function addProject(string memory _project) public {
        groupOfProjects.push(_project);
    }

    function getProjects() public view returns (string[] memory) {
        return groupOfProjects;
    }

    function getProjectIndex(
        string memory _project
    ) public view returns (uint) {
        for (uint i = 0; i < groupOfProjects.length; i++) {
            if (
                keccak256(abi.encodePacked(groupOfProjects[i])) ==
                keccak256(abi.encodePacked(_project))
            ) {
                return i;
            }
        }
        return 1000;
    }
}
