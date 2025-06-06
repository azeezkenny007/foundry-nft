-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""



all: clean remove install update build

standard-json:
	   forge verify-contract $(CONTRACT_ADDRESS) src/BasicNft.sol:BasicNft --show-standard-json-input --rpc-url $(SEPOLIA_RPC_URL) --compiler-version v0.8.28 > json.json



deploy/verify-Base-sepolia:
	forge script script/DeployRaffle.s.sol:DeployRaffle \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--account sepoliaWallet \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		--broadcast \
		-vvv

deploy-Nft:
	forge script script/DeployBasicNft.s.sol:DeployBasicNft \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--account sepoliaWallet \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		--broadcast \
		-vvv



deploy-MoodNft:
	forge script script/DeployMoodNft.s.sol:DeployMoodNft \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--account sepoliaWallet \
		--verify \
		--etherscan-api-key $(ETHERSCAN_API_KEY) \
		--broadcast \
		-vvv

mint-MoodNft:
	cast send 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "mintNft()" --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) - -vvv

flip-MoodNft:
	cast send 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512 "flipMood(uint256)" 0 --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) - -vvv

mint-Nft:
	forge script script/Interactions.s.sol:Interactions \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--account sepoliaWallet \
		--broadcast \
		-vvv

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install cyfrin/foundry-devops@0.2.2 --no-commit && forge install smartcontractkit/chainlink-brownie-contracts@1.1.1 --no-commit && forge install foundry-rs/forge-std@v1.8.2 --no-commit && forge install transmissions11/solmate@v6 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy:
	@forge script script/DeployRaffle.s.sol:DeployBasiNft $(NETWORK_ARGS)

mint:
	@forge script script/Interactions.s.sol:Interactions $(NETWORK_ARGS)

