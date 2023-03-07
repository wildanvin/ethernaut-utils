from web3 import Web3

alchemy_url = "YOUR_ALCHEMY_URL"

#alchemy_url = "http://127.0.0.1:8545"

# connect to an Ethereum node
w3 = Web3(Web3.HTTPProvider(alchemy_url))

# address of the smart contract
# contract_address = '0x38282F8D94DDd12A4A5A5108Eb252664b1b9145e'
contract_address = '0x400adc9753b1F16744EAfDf56533cc7FBd3F591f'

slot_0 = w3.eth.get_storage_at(contract_address, 0)
slot_1 = w3.eth.get_storage_at(contract_address, 1)
slot_2 = w3.eth.get_storage_at(contract_address, 2)
slot_3 = w3.eth.get_storage_at(contract_address, 3)
slot_4 = w3.eth.get_storage_at(contract_address, 4)
slot_5 = w3.eth.get_storage_at(contract_address, 5)
slot_6 = w3.eth.get_storage_at(contract_address, 6)
slot_7 = w3.eth.get_storage_at(contract_address, 7)
slot_8 = w3.eth.get_storage_at(contract_address, 8)
slot_9 = w3.eth.get_storage_at(contract_address, 9)
slot_10 = w3.eth.get_storage_at(contract_address, 10)


print(slot_0.hex())
print(slot_1.hex())
print(slot_2.hex())
print(slot_3.hex())
print(slot_4.hex())
print(slot_5.hex())
print(slot_6.hex())
print(slot_7.hex())
print(slot_8.hex())
print(slot_9.hex())
print(slot_10.hex())


