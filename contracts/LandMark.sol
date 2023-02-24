// SPDX-License-Identifier:MIT
// Adjust your own solc
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";

contract LandMark is ERC1155{
    address public bank;
    address public owner;

    constructor (address _owner, uint256 amount ,string memory url ) ERC1155(""){
        bank = msg.sender;
        owner = _owner;


        _mint(_owner,random(10000), amount,bytes(url));

    }


    function random(uint num) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty, 
        msg.sender))) % num;
    }

    
    function MintPieces(address to,uint256 id, uint256 amount) external returns (bool) {

        // address to,
        // uint256 id,
        // uint256 amount,
        // bytes memory data
        _mint(to, id, amount,"");
        return false;
    }
}