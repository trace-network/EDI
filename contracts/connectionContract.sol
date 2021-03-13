pragma solidity ^0.4.24;

contract connections{

address buyerAddress;
address supplierAddress;

constructor(address _buyer, address _supplier) public{
    buyerAddress = _buyer;
    supplierAddress = _supplier;
}

mapping (uint=>OrderData) orders;
uint orderCounter=1;

struct OrderData{
    string json;
    string status;
    mapping(uint=>string) versions;
    uint versionCounter;
}

modifier onlyParties(){
    require(msg.sender==buyerAddress || msg.sender==supplierAddress);
    _;
}

function createOrder(string details,string statusInfo) onlyParties public{
    OrderData memory order=OrderData({
        json:details,
        status:statusInfo,
        versionCounter:1
    });
    orders[orderCounter]=order;
    orderCounter++;
}

function updateStatus(uint index,string orderDetails,string statusData) onlyParties{
    OrderData storage order=orders[index];
    order.versions[order.versionCounter]=order.json;
    order.json=orderDetails;
    order.status=statusData;
    order.versionCounter=order.versionCounter+1;
}

function getOrderDetails(uint index) view onlyParties public returns(string){
    return orders[index].json;
}

function getOrderCounter() view public returns(uint){
    return orderCounter;
}

function getVersionCounter(uint index) view public returns(uint){
    return orders[index].versionCounter;
}

function getVersionDetails(uint index,uint version) view onlyParties public returns(string){
    return orders[index].versions[version];
}
}
