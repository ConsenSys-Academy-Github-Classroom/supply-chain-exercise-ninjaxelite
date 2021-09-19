pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

// Proxy contract for testing SupplyChain
contract SupplyChainProxy {
    address public target;
    bytes data;

    constructor(address _target) public {
        target = _target;
    }

    //prime the data using the fallback function.
    function() external {
        data = msg.data;
    }

    function execute() public returns (bool, bytes memory d) {
        return target.call(data);
    }
}

contract TestSupplyChain {
    // Test for failing conditions in this contracts:
    // https://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests

    // buyItem
    function testBuyItemWithoutEnoughFunds() public {
        SupplyChain sc = SupplyChain(DeployedAddresses.SupplyChain());

        bool result = sc.addItem("pear", 6);
        Assert.isFalse(result, "Result be true");
    }
    // test for failure if user does not send enough funds
    // test for purchasing an item that is not for Sale
    // shipItem
    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold
    // receiveItem
    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped
}
