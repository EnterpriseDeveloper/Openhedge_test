// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// get the OpenZeppelin Contracts for NFT collection
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract NFTCollection is ERC1155 {

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

    uint16 public constant maxSupply = 5000; // set the max supply of NFT's for your collection
    uint256 public constant TOKEN = 0;

    constructor() ERC1155("https://some.game/api/item/{id}.json"){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function createOpenhedgeNFT() public onlyOwner {
        require(!initialization); // check if NFT already initialized
       _mint(msg.sender, TOKEN, maxSupply, "");
        initialization = true;
    }

    function getGenomes(uint256 tokenId) public view returns(string memory) {
        // check if id exist
        require(tokenId <= maxSupply, "out of range");
        
        uint[] memory genomes = new uint[](parameters.length);
        // Generate random genomes from parameters
        for(uint16 i = 0; i < parameters.length; i++) {
            uint x = uint(keccak256(abi.encodePacked(tokenId, parameters[i]))) % parameters[i];
            genomes[i] = x;
        }
        // Generate string from genomes to return from function
        string memory output = "";
        for(uint16 i = 0; i < genomes.length; i++) {
            string memory character = "";
            if(i != 0){
                character = ",";
            }
            output = string(abi.encodePacked(output, character, Strings.toString(genomes[i])));
        }
        return string(abi.encodePacked("[", output, "]"));
    }
}
