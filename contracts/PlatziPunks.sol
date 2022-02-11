// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract PlatziPunks is ERC721, ERC721Enumerable {
    
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;
    address payable collectionAuthor;

    constructor(uint256 _maxSupply) ERC721("PlatziPunks", "PLPKS") {
        maxSupply = _maxSupply;
        collectionAuthor = payable(msg.sender);
    }

    function mint() public payable {
        uint256 current = _idCounter.current();
        require(current < maxSupply, "The maximum supply limit has been met");
        require(msg.value == uint(10), "Please add funds to pay the minting fee");
        _safeMint(msg.sender, current);
        collectionAuthor.transfer(msg.value);
        _idCounter.increment();
    }

    

    // Override required
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
