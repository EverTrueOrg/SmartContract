//SPDX-License-Identifier: Unlicense
pragma solidity  ^0.8.17;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract APToken is ERC20 {

    address private _owner ;

    mapping(address => uint) pointpool;
    uint public _settingdistance;
    modifier onlyOwner() { // Modifier
        require(
            msg.sender == _owner,
            "Only onwer can call this."
        );
        _;
    }

    constructor(string memory tokenname,string memory symbol) ERC20(tokenname,symbol){
        // _mint(msg.sender,initialtotal);
        _owner = msg.sender;
        _settingdistance = 500;
        console.log("Deploying a Greeter with tokenname:", tokenname);
    }


    function AddSignalPoint(address point, uint distance) external {
        pointpool[point] = distance;
    }

    //Beacon points 
    function MintWithCondition(address user,uint amount,address point) external returns(bool){
        
        // pointpool[point] 
        // require(distance  <= pointpool[point],"not fit min distance requirements");

        //send ap to user
        _mint(user,amount);
        return true;
    }

}