//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.18;

import { ERC20Burnable, ERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
/**
*@title DeepStableCoin
*@author Kirubha Karan
*Collateral: Exogenous(ETH & BTC)
*Minting : Algorithmic
*Relative Stability: Pegged to $1
*/
contract DeepStableCoin is ERC20Burnable,Ownable {
    error DeepStableCoin__MustBeMoreThanZero();
    error DeepStableCoin__BurnAmountExceedsBalance();
    error DeepStableCoin__NotZeroAddress();

    constructor() ERC20("DeepStableCoin","DSC") {}

    function burn(uint256 _amount) public override onlyOwner{
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0){
            revert DeepStableCoin__MustBeMoreThanZero();
        }
        if(balance < _amount){
            revert DeepStableCoin__BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }

    function mint(address _to,uint256 _amount) external onlyOwner returns (bool){
        if(_to == address(0)){
            revert DeepStableCoin__NotZeroAddress();
        }
        if(_amount <= 0){
            revert DeepStableCoin__MustBeMoreThanZero();
        }
        _mint(_to,_amount);
        return true;
    } 
}