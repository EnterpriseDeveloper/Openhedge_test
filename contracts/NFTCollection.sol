// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// get the OpenZeppelin Contracts for NFT collection
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTCollection is ERC721URIStorage {

    /*   
     * @notice These are parameters for NFT that will generate unique NFT from tokenID. Stored in the parameters array by index.
     * BackgroundColor: from 0 to 60
     * BackgroundEffect: from 0 to 60
     * Wings: from 0 to 10
     * SkinColor: from 0 to 40
     * SkinPattern: from 0 to 10
     * Body: from 0 to 100
     * Mouth: from 0 to 50
     * Eyes: from 0 to 60
     * Hat: from 0 to 100
     * Pet: from 0 to 10
     * Accessory: from 0 to 25
     * Border: from 0 to 30
    */
    uint8[] parameters = [60, 60, 10, 40, 10, 100, 50, 60, 100, 10, 25, 30];

    address public owner;
    bool public initialization = false;
    
    // keep count of the tokenId
    using Counters for Counters.Counter; // keep track of the token id's
    Counters.Counter private _tokenIds;

    uint16 public constant maxSupply = 5000; // set the max supply of NFT's for your collection

    constructor() ERC721("openhedge", "OPE") {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function createOpenhedgeNFT() public onlyOwner {
        require(!initialization); // check if NFT already initialized
        //function to create nfts
        for (uint16 i = 0; i < maxSupply; i++) {
            uint256 newItemId = _tokenIds.current(); // get the tokenId
            _safeMint(msg.sender, newItemId); // mint the nft from the sender account
          //  _setTokenURI(newItemId, string(bytes.concat(bytes("https://someWebpage.com/"), bytes(Strings.toString(newItemId))))); // add the contents to the nft
            _tokenIds.increment(); // increment the token
        }
        initialization = true;
    }

    function getOptcode(uint256 tokenId) public view returns(string memory) {
        uint[] memory optcode = new uint[](parameters.length);
        for(uint16 i = 0; i < parameters.length; i++) {
            uint x = uint(keccak256(abi.encodePacked(tokenId, parameters[i]))) % parameters[i];
            optcode[i] = x;
        }
        string memory output = "";
        for(uint16 i = 0; i < optcode.length; i++) {
            string memory character = "";
            if(i != 0){
                character = ",";
            }
            output = string(abi.encodePacked(output, character, Strings.toString(optcode[i])));
        }
        return string(abi.encodePacked("[", output, "]"));
    }
}
