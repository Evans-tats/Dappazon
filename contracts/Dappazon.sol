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
    struct Order {
        uint256 time;
        Item item;
    }
    mapping(uint256 => Item) public items;
    mapping (address => uint256) public orderCount;
    mapping(address => mapping(uint256 => Order)) public orders;

    
    event List (string name, uint256 cost, uint256 quantity);
    //event Buy (address buyer, uint256 orderId, uint256 ItemId);
    
    modifier onlyDeployer {
        require(msg.sender == owner, "only owner can call this function");
        _;
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

    ) public onlyDeployer {
        //create item struct
        Item memory item = Item(_id, _name, _category,_image, _cost, _rating, _stock); 
        //Save Item Struct to blockchain
        items[_id] = item;
        //emit event

        emit List(_name, _cost, _stock);

    }

    function buy(uint256 _id) public payable {
        //fetch item
        Item memory item = items[_id];

        require(msg.value >= item._cost);
        require(item._stock > 0);
        //create order
        Order memory order = Order(block.timestamp, item);
        //save order to blockchain
        orderCount[msg.sender]++;
        orders[msg.sender][orderCount[msg.sender]] = order;

        //subtract stock
        items[_id]._stock = item._stock - 1;
        //emit event
        //event Buy (msg.sender, orderCount[msg.sender], item.id);


    }

    //withdraw funds
    function withdraw() public onlyDeployer() {
        (bool success,) = owner.call{value: address(this).balance}("");
        require(success);
    }
}
