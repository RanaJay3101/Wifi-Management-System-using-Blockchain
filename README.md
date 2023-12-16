# Wifi Management System Smart Contract

## Introduction
This project is a Solidity smart contract designed for managing Wi-Fi access for students at Nirma University. The contract allows students to register using their MAC address, and the system assigns them a unique IP address. The contract is created by Rana Jay on 29-11-2023 under the guidance of Nilesh Sir.

## Smart Contract Overview
### `WifiManagementSystem`
- Manages student registration and IP address assignment.
- Admin has special privileges for certain functions.

### Student Structure
- `name`: Name of the student.
- `rollNo`: Roll number of the student.
- `macAddress`: MAC address of the student's device.
- `isRegistered`: Boolean indicating whether the student is registered.
- `ipAddress`: Fixed-size bytes representing the assigned IP address.

## Functions
1. **`registerStudent`**
   - Registers a student with a valid name, roll number, and MAC address.
   - Generates and assigns an IP address to the student.

2. **`getStudentIpAddress`**
   - Returns the IP address of the calling student.

3. **`getHumanReadableIpAddress`**
   - (Admin Only) Converts the IP address of a specified student to a human-readable format.

4. **`convertIpToHumanReadable`**
   - (Internal) Converts a bytes4 IP address to a human-readable string.

5. **`validateMacAddress`**
   - (Internal) Validates the format of a MAC address.

6. **`validateRollNumber`**
   - (Internal) Validates the format of a roll number.

7. **`generateIpAddress`**
   - (Internal) Generates an IP address based on the MAC address.

8. **`updateAdmin`**
   - (Admin Only) Updates the address of the admin.

## Modifiers
1. **`onlyAdmin`**
   - Ensures that only the admin can call specific functions.

2. **`onlyStudent`**
   - Ensures that only registered students can call specific functions.

## Deployment
- Deploy the contract to the Ethereum blockchain.
- The deployer becomes the admin.

## Usage
1. **Student Registration**
   - Call `registerStudent` with a valid name, roll number, and MAC address.

2. **Get Student IP Address**
   - Call `getStudentIpAddress` to retrieve the assigned IP address.

3. **Get Human-Readable IP Address**
   - (Admin Only) Call `getHumanReadableIpAddress` with the student's roll number.

4. **Update Admin**
   - (Admin Only) Call `updateAdmin` to update the admin address.

## Security Considerations
- Ensure that only authorized entities can update the admin address.
- The contract uses placeholder logic for IP address generation; replace it with a secure and appropriate algorithm.

## Author
- Rana Jay
- Date: 29-11-2023
- Guided by Nilesh Sir


