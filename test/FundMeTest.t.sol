// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address user = makeAddr("antoine");

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(user, 100e18);
    }

    function testMinimumUsd() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwner() public view {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testFund() public {
        fundMe.fund{value: 5e18}();
        assertEq(fundMe.getAddressToAmountFunded(address(this)), 5e18);
    }

    function testFundFailWithLessThanMinimum() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdateDataStructure() public {
        fundMe.fund{value: 5e18}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(address(this));
        assertEq(amountFunded, 5e18);
    }

    function testWithdrawFunds () public {
        vm.prank(user);
        fundMe.fund{value: 5e18}();
        vm.prank(fundMe.i_owner());
        fundMe.withdraw();
        assertEq(fundMe.getAddressToAmountFunded(user), 0);
    }

    function getVersion() public view {
        assertEq(fundMe.getVersion(), 4);
    }

    function testAddsFundersToArrayOfFunders() public {
        vm.prank(user);
        fundMe.fund{value: 5e18}();
        assertEq(fundMe.getFunder(0), user);
    }
}
