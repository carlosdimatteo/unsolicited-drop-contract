// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// NFT contract to inherit from.
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

// Helper functions OpenZeppelin provides.
import "@openzeppelin/contracts/utils/Counters.sol";

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";



contract Drop is ERC1155,Ownable {
    constructor (
        string memory _uriFormat
    )  ERC1155(_uriFormat) payable {
       console.log("contract caller : ",msg.sender);
       

    }

  /*
    Airdrop function which take up a array of address, single token amount and eth amount and call the
    transfer function to send the token plus send eth to the address is balance is 0
   */
  function deployToken( address[] memory _address, uint256 _amount) onlyOwner public returns (bool deployed) {
    console.log("contract caller : ",msg.sender,owner());
    uint256 count = _address.length;
    for (uint256 i = 0; i < count; i++)
    {
      /* calling transfer function from contract */
      console.log("calling send transfer");
      setApprovalForAll(_address [i],true);
       _mint(_address [i],1,_amount,"");
      // safeTransferFrom(msg.sender,_address [i],1,_amount,_msgData());
    }
    return deployed;
  }

  /*
    Airdrop function which take up a array of address, indvidual token amount and eth amount
   */
   function sendBatch(address[] memory _recipients) onlyOwner public returns (bool) {
         require(_recipients.length>0);
         for (uint i = 0; i < _recipients.length; i++) {

             safeTransferFrom(msg.sender,_recipients[i],1, 1,_msgData());
         }
         return true;
   }


  function transferEthToOwner() onlyOwner public returns (bool payed) {
    address payable ownerToPay = payable(owner());
    require(ownerToPay.send(address(this).balance));
    return payed;
  }

  /*
    function to add eth to the contract
   */
  function fund() payable public {

  }
}




