pragma solidity ^0.8.0;

contract SupplyChain {
    struct Item {
        uint id;
        address owner;
    }

    mapping(uint => Item) public items;

    event Transfer(uint indexed itemId, address indexed previousOwner, address indexed newOwner);

    modifier onlyItemOwner(uint itemId) {
        require(items[itemId].owner == msg.sender, "Not the item owner");
        _;
    }

    modifier validAddress(address addr) {
        require(addr != address(0), "Invalid address");
        require(addr != address(this), "Cannot transfer to contract itself");
        _;
    }

    function transferItem(uint itemId, address newOwner)
        public
        onlyItemOwner(itemId)
        validAddress(newOwner)
    {
        address previousOwner = items[itemId].owner;
        items[itemId].owner = newOwner;
        emit Transfer(itemId, previousOwner, newOwner);
    }
}
