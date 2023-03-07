# Setup
from web3 import Web3

alchemy_url = "YOUR_ALCHEMY_URL"
w3 = Web3(Web3.HTTPProvider(alchemy_url))

# Print if web3 is successfully connected
print(w3.isConnected())

# Get the latest block number
latest_block = w3.eth.block_number
print(latest_block)

info = w3.eth.get_block(latest_block)
b_hash= info.hash.hex()
print(b_hash)

num = int(info.hash.hex(), 16)
print(num)

