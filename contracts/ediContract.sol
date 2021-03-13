pragma solidity^0.4.24;

contract Edi{

    mapping(address=>bool) public registeredCompanies;
    address[] public registered;
    mapping(address=>address[]) mySuppliers;
    mapping(address=>address[]) myBuyers;
    address public admin;

    constructor() public{
        admin = msg.sender;
    }

    function () public payable{

    }

    function registerUser(address _company) public{
        registeredCompanies[_company]=true;
        registered.push(_company);
    }

    function establishConnection(address _buyer,address _vendor) public{
        mySuppliers[_buyer].push(_vendor);
        myBuyers[_vendor].push(_buyer);
    }

    function getSuppliers(address _company) public view returns(address[]){
        return mySuppliers[_company];
    }

    function getBuyers(address _company) public view returns(address[]){
        return myBuyers[_company];
    }

    function transferFundsToAdmin(uint amount) public{
        require(msg.sender == admin);
        admin.transfer(amount);
    }

}
