// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// get the OpenZeppelin Contracts for NFT collection
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTCollection is ERC721URIStorage {

    address public owner;
    // struct Parameters{
    //     uint8 BackgroundColor;
    //     uint8 BackgroundEffect;
    //     uint8 Wings;
    //     uint8 SkinColor;
    //     uint8 Body;
    //     uint8 Mouth;
    //     uint8 Eyes;
    //     uint8 Hat;
    //     uint8 Pet;
    //     uint8 Accessory;
    //     uint8 Border;
    // }
/*   
* @notice this is parameters for NFT that generated from tokenID and stored in parameters array
* BackgroundColor: from 0 to 60
* BackgroundEffect: from 0 to 60
* Wings: from 0 to 10
* SkinColor: from 0 to 40
* SkinPattern: from 0 to 10
* Body: from 0 to 100
* Mouth: from 0 to 50
* Eyes: from 0 to 60
* Hat:from 0 to 100
* Pet: from 0 to 10
* Accessory: from 0 to 25
* Border: from 0 to 30
*/
    uint8[] param = [60, 60, 10, 40, 10, 100, 50, 60, 100, 10, 25, 30];
    
    // keep count of the tokenId
    using Counters for Counters.Counter; // keep track of the token id's
    Counters.Counter private _tokenIds;

    uint256 public constant maxSupply = 5000; // set the max supply of NFT's for your collection

    constructor() ERC721("openhedge", "OPE") {
        owner = msg.sender;
    }

    function createOpenhedgeNFT() public {
        //function to create nfts
        uint256 newItemId = _tokenIds.current(); // get the tokenId

        require(newItemId < maxSupply); // check if the total supply has been reached

        _safeMint(msg.sender, newItemId); // mint the nft from the sender account

        _setTokenURI(newItemId, "https://someWebpage.com/" + string(newItemId)); // add the contents to the nft
        // the content of this nft is on the url above. This means that the nft is an off-chain nft
        // if the server with the content changes then the image in the url changes

        _tokenIds.increment(); // increment the token, so when the next person calls the function it will be the next token in line
    }

    function getOptcode(uint256 tokenId) public view returns(uint256) {
        return uint(keccak256(abi.encodePacked(tokenId, msg.sender, tokenId))) % 100000000000000000000000000;
    }
}
