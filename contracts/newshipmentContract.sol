pragma solidity^0.4.24;

contract ShipmentData{

    uint i=0;
    uint j=0;

    struct Shipment{
        bytes32 tradelinkShipmentNumber;
        string  referenceShipmentNumber;
        string  tradelinkPoNumber;
        address createdBy;
        string  shipmentJson;
        string  status;
        uint    index;
        string  date;
    }

    struct Receiving{
        bytes32 tradelinkShipmentNumber;
        string  tradelinkReceivingNumber;
        string  referenceReceivingNumber;
        string  tradelinkPoNumber;
        address createdBy;
        address createdFor;
        string  receivingJson;
        uint    index;
    }

    mapping (address=>bytes32[]) userShipments;
    Shipment[] public shipmentsArr;
    mapping (address=>string[]) userReceivings;
    Receiving[] public receivingArr;

    function createShipment(bytes32 _tradelinkShipmentNumber,string _referenceShipmentNumber,address _createdBy,string _shipmentJson,string _status, string _tradelinkPoNumber,string _date) public{
        Shipment memory details= Shipment({
                tradelinkShipmentNumber:_tradelinkShipmentNumber,
                referenceShipmentNumber:_referenceShipmentNumber,
                tradelinkPoNumber:_tradelinkPoNumber,
                createdBy:_createdBy,
                shipmentJson:_shipmentJson,
                status:_status,
                index:i,
                date:_date
            });
        userShipments[_createdBy].push(_tradelinkShipmentNumber);
        shipmentsArr.push(details);
        i++;
    }

    function createReceiving(bytes32 _tradelinkShipmentNumber,string _tradelinkReceivingNumber,string _referenceReceivingNumber, string _tradelinkPoNumber,address _createdBy, address _createdFor,string _receivingJson) public{
        Receiving memory details= Receiving({
                tradelinkShipmentNumber:_tradelinkShipmentNumber,
                tradelinkReceivingNumber:_tradelinkReceivingNumber,
                tradelinkPoNumber:_tradelinkPoNumber,
                referenceReceivingNumber:_referenceReceivingNumber,
                createdBy:_createdBy,
                createdFor:_createdFor,
                index:j,
                receivingJson:_receivingJson
            });
        userReceivings[_createdBy].push(_tradelinkReceivingNumber);
        receivingArr.push(details);
        j++;
    }

    function changeShipmentStatus(uint _index, string _status) public {
        shipmentsArr[_index].status=_status;
    }

    function getTotalShipmentsCount() public view returns(uint){
        return shipmentsArr.length;
    }

    // function changeReceivingStatus(uint _index, string _status) public {
    //     receivingArr[_index].status=_status;
    // }

    function getTotalReceivingCount() public view returns(uint){
        return receivingArr.length;
    }

}
