// SPDX-License-Identifier:MIT
// Adjust your own solc
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "hardhat/console.sol";
import "./LandMark.sol";

library IterableMapping {
    // Iterable mapping from address to uint;


    struct pointInfo{
        string name;
        address lord;
        address conaddress;
        string imageposition;
    }

    struct Map {
        string[] keys;
        string[] namelist;
        string[] urllist;
        // mapping(string => pointInfo) values; 
        
        mapping(string => pointInfo) values; 
        mapping(string => uint) indexOf;   
        mapping(string => bool) inserted;
    }

    function get(Map storage map, string memory key) public view returns (pointInfo memory) {
        return map.values[key];
    }

    function getKeyAtIndex(Map storage map, uint index) public view returns (string memory) {
        return map.keys[index];
    }

    function size(Map storage map) public view returns (uint) {
        return map.keys.length;
    }

    function set(
        Map storage map,
        string memory key,
        pointInfo memory val
    ) public {
        if (map.inserted[key]) {
            map.values[key] = val;
        } else {
            map.inserted[key] = true;
            map.values[key] = val;
            map.indexOf[key] = map.keys.length;
            map.keys.push(key);
            map.namelist.push(val.name);
            map.urllist.push(val.imageposition);
        }
    }

    function remove(Map storage map, string memory key) public {
        if (!map.inserted[key]) {
            return;
        }

        delete map.inserted[key];
        delete map.values[key];

        uint index = map.indexOf[key];
        uint lastIndex = map.keys.length - 1;
        string memory lastKey = map.keys[lastIndex];

        map.indexOf[lastKey] = index;
        delete map.indexOf[key];

        map.keys[index] = lastKey;
        map.keys.pop();
    }
}


contract LandMarkFactory {

    using IterableMapping for IterableMapping.Map;
    using IterableMapping for IterableMapping.pointInfo;


    IterableMapping.Map private map;
    LandMark[] public LandMarkMarket;

    address _APToken;

    uint256 _initPrice = 10;


    //workaroud for the library not work issue
    mapping(string => IterableMapping.pointInfo) TestMap;
    string[] lalolist;

    constructor(address _owner, address aptoken) {
        _APToken = aptoken;
        _owner = msg.sender;
    }


    function getLalo() external view returns(string[] memory,string[] memory,string[] memory) {

        return (map.keys,map.namelist,map.urllist);
    }
    function createLandMark(string memory lalo,string memory name  ,uint256 pieceamount ,string memory url) external payable returns(address,uint) {

        // IERC20(_APToken).approve(address(this), _initPrice);
        // IERC20(_APToken).transferFrom(msg.sender,address(this),_initPrice);
        //消耗ap点进行创建合约        
        require(map.inserted[lalo] == false, "current point has already been created Land");        
        console.log(
            "point 1"
        );
        LandMark LandMarkInstance = new LandMark(msg.sender,pieceamount,url );
        // console.log(
        //     "point 2"
        // );
        address LandMarkAddress = address(LandMarkInstance);
        IterableMapping.pointInfo memory test =  IterableMapping.pointInfo({
             name: name,
            lord: msg.sender,
            conaddress: LandMarkAddress,
            imageposition: url
        });
        // map.set(lalo,test);
        TestMap[lalo] = test;
        lalolist.push(lalo);
        // map.set(lalo, IterableMapping.pointInfo({
        //     name: name,
        //     lord: msg.sender,
        //     conaddress: LandMarkAddress,
        //     imageposition: url
        // }));

        LandMarkMarket.push(LandMarkInstance);

        // return (LandMarkAddress,uint(0));
        return (address(this),uint(0));
    }
}