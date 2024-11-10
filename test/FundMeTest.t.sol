// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {

    FundMe private fundMe;

    function setUp() external {
        fundMe = new FundMe();
    }

    function testMinimumUsd() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwner() public view {
        assertEq(fundMe.i_owner(), address(this));
    }

}