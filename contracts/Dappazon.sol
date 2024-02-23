// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dappazon {
    address public owner;

    struct Item {
        uint256 _id;
        string  _name;
        string  _category;
        string  _image;
        uint256 _cost;
        uint256 _rating;
        uint256 _stock;

    }

    
    
    constructor() {
        owner= msg.sender;
    }

    function list(
        uint256 _id,
        string memory _name,
        string memory _category,
        string memory _image,
        uint256 _cost,
        uint256 _rating,
        uint256 _stock

    ) public {
        Item memory item = Item(_id, _name, _category,_image, _cost, _rating, _stock); 
    }
}
