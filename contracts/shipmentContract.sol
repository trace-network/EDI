pragma solidity ^ 0.4.24;

contract ShipmentData{

    uint i=0;

    struct Shipment{
        bytes32 tradelinkShipmentNumber;
        string referenceShipmentNumber;
        string tradelinkPoNumber;
        address createdBy;
        string shipmentJson;
        string status;
        uint   index;
        string date;
    }

    mapping (address=>bytes32[]) userShipments;
    Shipment[] public shipmentsArr;

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

    function changeShipmentStatus(uint _index, string _status) public {
        shipmentsArr[_index].status=_status;
    }

    function getTotalShipmentsCount() public view returns(uint){
        return shipmentsArr.length;
    }

}
