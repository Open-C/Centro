pragma solidity ^0.5.0;

import "../interfaces/ILendingPool.sol";
import "../interfaces/ILendingPoolAddressProvider.sol";
import "../interfaces/IERC20Token.sol";
import "../ContractCaller.sol";

contract MoolaHelper {
	ILendingPoolAddressesProvider lpa = ILendingPoolAddressesProvider(0x6EAE47ccEFF3c3Ac94971704ccd25C7820121483);

	function getLendingPool() internal view returns (address) {
		return lpa.getLendingPool();
	}
} 

contract IStorage {
	function getAddressProvider(string memory _name) public view returns (address);
	function getEthAddress() public pure returns (address);
}

contract MoolaConnector is ContractCaller {
	address store;
	address owner;
	mapping(address => uint256) private deposited;
	address[] private token_addr;
	mapping (address => bool) auth;


	function deposit(address _token, uint256 _amount) external payable {
		ILendingPoolAddressesProvider lpa = ILendingPoolAddressesProvider(IStorage(store).getAddressProvider("moola"));        
		ILendingPool moola = ILendingPool(lpa.getLendingPool());
		if (_token != IStorage(store).getEthAddress()) {
			IERC20Token token = IERC20Token(_token);
			require(_amount <= token.balanceOf(address(this)), "Not enough moneys.");
			token.approve(address(moola), _amount);
			moola.deposit(_token, _amount, 0);
		} else {
			moola.deposit.value(msg.value)(_token, msg.value, 0);
		}
	}

	function withdraw(address _token, uint256 _amount) external payable {
		ILendingPoolAddressesProvider lpa = ILendingPoolAddressesProvider(IStorage(store).getAddressProvider("moola"));        
		ILendingPool moola = ILendingPool(lpa.getLendingPool());
		moola.redeemUnderlying(_token, address(this), _amount, 0);
	}

	function getBalance(address[] calldata _tokens) external view returns (uint256[] memory) {
		ILendingPoolAddressesProvider lpa = ILendingPoolAddressesProvider(IStorage(store).getAddressProvider("moola"));        
		ILendingPool moola = ILendingPool(lpa.getLendingPool());
		uint256[] memory balances = new uint256[](_tokens.length);
		for (uint i = 0 ; i < _tokens.length; i++) {
			(uint256 currentATokenBalance,
			,
			,
			,
			,
			,
			,
			,
			,
			) = moola.getUserReserveData(_tokens[i], address(this));
			balances[i] = currentATokenBalance;
		}
		return (balances);
	}
}