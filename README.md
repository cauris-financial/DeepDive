# Smart Contract for DeepDive

## Summary

DeepDive is a service that allows for the storage of off-chain financial data on any EVM compatible network. Deployments included in this repo support Ethereum and Celo but more networks can be added.

Data is stored off-chain on the Pinata IPFS network. The data is stored as JSON. The hash lookup for this JSON data is stored on the DeepDive smart contract so access can be managed on-chain.

A Node.js server allows for the uploading of .xlsx files. These files are then converted into JSON files and stored on IPFS with a corresponding hash.

## Front End Implementation

We have deployed a front end implementation for these smart contracts here: https://github.com/cauris-financial/cauris_app_web

Screens from the DeepDive front end:

**View Existing Pools**

In this screen an operator selects the pool they would like to view.

![alt text](https://storage.googleapis.com/cauris_deep_dive/deep_dive1.png)

**Operator Admin**

In this screen an operator updates the data on both IPFS and the on-chain network.

![alt text](https://storage.googleapis.com/cauris_deep_dive/deep_dive2.png)

**Pool View**

In this screen a whitelisted investor can view the analysis on a particular pool

![alt text](https://storage.googleapis.com/cauris_deep_dive/deep_dive3.png)
