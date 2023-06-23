//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.18;

import{Script} from "forge-std/Script.sol";
import {DeepStableCoin} from "../src/DeepStableCoin.sol";
import {DSCEngine} from "../src/DSCEngine.sol";
import{HelperConfig} from "./HelperConfig.s.sol";

contract DeployDSC is Script {
    address[] public tokenAddresses;
    address[] public priceFeedAddresses;

    function run() external returns (DeepStableCoin,DSCEngine,HelperConfig){
        HelperConfig config = new HelperConfig();
        (address wethUsdPriceFeed,address wbtcUsdPriceFeed,address weth,address wbtc,
        uint256 deployerKey) = config.activeNetworkConfig();

        tokenAddresses = [weth,wbtc];
        priceFeedAddresses = [wethUsdPriceFeed,wbtcUsdPriceFeed];

        vm.startBroadcast(deployerKey);
        DeepStableCoin dsc = new DeepStableCoin();
        DSCEngine engine = new DSCEngine(tokenAddresses,priceFeedAddresses,address(dsc));

        dsc.transferOwnership(address(engine));
        vm.stopBroadcast();
        return(dsc,engine,config);
    }
}