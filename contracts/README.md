## Deployed Contracts

### Alfajores

- Migrations: `0x3c4Dc782702f7a672b3FeAdE1f0093603F0605aA`
- Storage: `0x3c4Dc782702f7a672b3FeAdE1f0093603F0605aA`
- CentroMain: `0xBf667831a019151192a93d8FF07f64Ff8d4f799F`
- MoolaConnector: `0xfd2e55632e53472F2CEDd2Da7eE7a02209367394`
- ExchangeConnector: `0xf0C7e841f6F77EC6DC8DB51770D7510cFAd17cE9`
- CentroWallet: `0x043715CB875Ef7db8A1681cb223571f997a362ee`


## CentroMain - Forward-facing Contract
----------------------------------------------------------------------
`newWallet(String name)`
* Creates a wallet for the user initiating the call
* Sets new wallet to be the current wallet for user
-----------------------------------------------------------------------
`getAccountIDs()`
* Returns an array of ids, where each id represents a smart wallet owned by the user
------------------------------------------------------------------------
`persistWallet(uint256 id)`
* Sets the default wallet for a user
* User must be the owner of the wallet
---------------------------------------------------------------------------
`getAccountOverview()`
* Returns an array of Wallet objects owned by the user
* Return type:
   * [
{ String name,
String role,
Address addr,
Address owner,
Uint256 id }
]

---------------------------------------------------------------------------
`getWalletBalance(uint256 walletID)`
   * Returns an array of `token` addresses, and balances of the corresponding token
   * To use a persisted wallet, use `walletID` = 0
   * Return type:
      * {
Tokens : [0x988321, 0x…..]
Balances: [10, 2]
}

---------------------------------------------------------------------------
`deposit(address token, uint256 amount, uint256 walletID)`
* Deposits an `amount` of `token` into the wallet corresponding to walletID
* To use a persisted wallet, use `walletID` = 0
      
---------------------------------------------------------------------------
`moolaDeposit(address token, uint256 amount, uint256 walletID)`
* Transfers funds to Moola
* To use a persisted wallet, `walletID` = 0
      
---------------------------------------------------------------------------
`withdraw(address token, uint256 amount, uint256 walletID)`
* Withdraws `amount` of `token` from the smart wallet corresponding to walletID
* To use a persisted wallet, `walletID` = 0
      
---------------------------------------------------------------------------
`moolaWithdraw(address token, uint256 amount, uint256 walletID)`
* Transfer funds from moola back into smart wallet
* `walletID` = 0 to use persisted wallet for user
      
---------------------------------------------------------------------------
`buyCelo(uint256 amount, uint256 maxSellAmount, uint256 walletID)`
* Places a limit order for `amount` of celo, setting the maximum amount of cUSD to sell
* `walletID` = 0 to use persisted wallet
      
---------------------------------------------------------------------------
`sellCelo(uint256 amount, uint256 minBuyAmount, uint256 walletID)`
* Places a limit order to sell `amount` of celo for a minimum amount of cUSD in exchange
* `walletID` = 0 to use persisted wallet
      
---------------------------------------------------------------------------
`send(address token, uint256 receiver, uint256 amount, uint256 walletID)`
* Transfers `amount` of `token` to the smart wallet corresponding to receiver.
* `walletID` = 0 to use persisted wallet
