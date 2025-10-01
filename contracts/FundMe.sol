// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 minUsd = 1e18;
    address[] public  funders;
    mapping(address funders => uint256 amount) public addressToAmountFunded;
    address public owner;
    function fund() public payable  {
        // Allow users to send $
        // Have a minimum $ sent

        require(msg.value.getConvertionRate() >= minUsd , "didn't see enought ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    constructor(){
        owner = msg.sender;
    }

    function withdraw() public onlyOwner {
        for(uint8 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++){
            address funder = funders[fundersIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);


        // sender
        // msg.sender = address

        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        
        // call
        (bool callSuccess, )  = payable(msg.sender).call{value : address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Sender is not owner");
        _;
    }

}