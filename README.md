# Test task for Wisdomise startup
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
