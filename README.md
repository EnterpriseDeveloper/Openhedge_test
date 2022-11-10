# Test task for Openhedge company
## Before initalizating project be shure that you have node v14.18.2 and npm 6.14.15

## Installation and deploying
Instal the dependencies
```sh
npm i
```

Create a mnemonic and send some [tokens](https://faucet.ropsten.be/) to the account on the Ropsten network.
```sh
npm run gen:ropsten-key
```

Deploy smart contracts to the Ropsten network.
```sh
npm run deploy:ropsten
```
Or you can find smart contracts addresses that have alredy been deployed in `build/contracts` folder.

## Testing
For run testing, be sure that you have installed Ganache. Run Ganache on the local machine and run
```sh
npm run test
```

## Logic
1. For the cheapest deployment, I chose the `ERC-1155` standard token. It allows us to deploy an NFT collection with as many amounts of tokens as you want in one function call. It will significantly reduce gas costs for the deployer.
2. For generating genomes I stored parameters in an array that will allow us to use this for random genome generation in the future. It very cheap approach since we use `uint8` instead of `map` and `structure`. One inconvenience for code style since, maybe, it will be less code readable at the future development.
3. For generating the genome I stick to the unique `tokenId`, or it can be an index of the token. It will allow us to very quickly check which genome has each NFT token by passing the `tokenID` value to the `getGenomes` function. Since this function is a `view`, it means that this function is free for usage since it does not have any effect on storage. And then we can reuse this function to the future development.

## Improvement
1. To avoid cheating from users, we can add structure to the `createOpenhedgeNFT` function and generate a unique tokenId for each NFT and then use them inside the `getGenomes` function. It will help us to avoid cheating because the advanced user can reuse the `getGenomes` function and pick for himself most powerful NFT if this NFT will be used in the Game like Pokemon :) 
Of course, for generating a unique tokenID better to use [Chainlink](https://docs.chain.link/docs/vrf/v2/introduction/) since we know that it's not possible to generate a real unique number in an EVM machine. 


    