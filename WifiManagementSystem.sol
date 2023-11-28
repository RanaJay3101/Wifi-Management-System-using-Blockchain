// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Created By rana Jay on 29-11-2023 under guidence of Nilesh Sir .
contract WifiManagementSystem {
    address public admin;

    struct Student {
        string name;
        string rollNo;
        string macAddress;
        bool isRegistered;
        bytes4 ipAddress;  // Use fixed-size bytes for IP address
    }

    mapping(string => Student) public studentsByRollNo;
    mapping(address => string) public rollNoByAddress;

    event StudentRegistered(address indexed studentAddress, string name, string rollNo, string macAddress, bytes4 ipAddress);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    modifier onlyStudent() {
        require(studentsByRollNo[rollNoByAddress[msg.sender]].isRegistered, "Student not registered");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerStudent(string memory _name, string memory _rollNo, string memory _macAddress) external {
        require(!studentsByRollNo[_rollNo].isRegistered, "Student already registered");

        require(bytes(_name).length > 0, "Name cannot be empty");

        require(validateRollNumber(_rollNo), "Invalid roll number format");

        require(validateMacAddress(_macAddress), "Invalid MAC address format");

        studentsByRollNo[_rollNo] = Student({
            name: _name,
            rollNo: _rollNo,
            macAddress: _macAddress,
            isRegistered: true,
            ipAddress: generateIpAddress(_macAddress)
        });

        rollNoByAddress[msg.sender] = _rollNo;

        emit StudentRegistered(msg.sender, _name, _rollNo, _macAddress, studentsByRollNo[_rollNo].ipAddress);
    }

    function getStudentIpAddress() external view onlyStudent returns (bytes4) {
        string memory rollNo = rollNoByAddress[msg.sender];
        return studentsByRollNo[rollNo].ipAddress;
    }

    function getHumanReadableIpAddress(string memory _rollNo) external view onlyAdmin returns (string memory) {
        require(studentsByRollNo[_rollNo].isRegistered, "Student not registered");
        return convertIpToHumanReadable(studentsByRollNo[_rollNo].ipAddress);
    }

    // Off-chain conversion function for IP address
    function convertIpToHumanReadable(bytes4 ip) internal pure returns (string memory) {
        return string(abi.encodePacked(ip, ".", ip >> 8, ".", ip >> 16, ".", ip >> 24));

    }

    function validateMacAddress(string memory _macAddress) internal pure returns (bool) {
    bytes memory macBytes = bytes(_macAddress);

    // Check the overall length
    if (macBytes.length != 17) {
        return false;
    }

    // Check the specific format
    for (uint256 i = 0; i < 17; i += 3) {
        if (
            (i == 2 || i == 5 || i == 8 || i == 11 || i == 14) && macBytes[i] != ":" ||
            (i != 2 && i != 5 && i != 8 && i != 11 && i != 14) && (uint8(macBytes[i]) < 48 || uint8(macBytes[i]) > 70 || (uint8(macBytes[i]) > 57 && uint8(macBytes[i]) < 65))
        ) {
            return false;
        }
    }

    return true;
}



    function validateRollNumber(string memory _rollNo) internal pure returns (bool) {
        bytes memory rollBytes = bytes(_rollNo);

        if (rollBytes.length != 8 || rollBytes[0] != "2" || rollBytes[1] != "0" || rollBytes[2] != "B" || rollBytes[3] != "C" || rollBytes[4] != "E") {
            return false;
        }

        for (uint256 i = 5; i < rollBytes.length; i++) {
            if (uint8(rollBytes[i]) < 48 || uint8(rollBytes[i]) > 57) {
                return false;
            }
        }

        return true;
    }

    function generateIpAddress(string memory _macAddress) internal pure returns (bytes4) {
        // Placeholder logic for IP address generation
        // Replace with your actual logic for IP address generation
        bytes4 ipAddress = bytes4(keccak256(abi.encodePacked(_macAddress)));
        return ipAddress;
    }

    function updateAdmin(address _newAdmin) external onlyAdmin {
        admin = _newAdmin;
    }
}
