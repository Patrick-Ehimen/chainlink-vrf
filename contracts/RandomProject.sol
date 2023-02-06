// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract Randomn {
    string[] public groupOfProjects;

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

    function random(uint _random) public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        msg.sender
                    )
                )
            ) % _random;
    }

    function getRandomProject() public view returns (string memory) {
        uint _random = random(groupOfProjects.length);
        return groupOfProjects[_random];
    }
}
