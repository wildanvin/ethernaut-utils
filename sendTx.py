from web3 import Web3

# connect to a local Ethereum node
w3 = Web3(Web3.HTTPProvider('your_infura_link'))

# set the sender account and private key
sender = '0x3163C23658CB4921bB4026eBAEB84E9b0C5121Cc'
private_key = 'your_private_key'

# create a transaction object
tx = {
    'to': '0x83dc1eD199c324CDC41473155bcb89910ba7D031',
     # 'value': w3.toWei(1, 'ether'),
    'gas': 50000,
    'gasPrice': w3.toWei(50, 'gwei'),
    'nonce': w3.eth.getTransactionCount(sender),
    'data': '0xdd365b8b',
}

# sign the transaction with the private key
signed_tx = w3.eth.account.signTransaction(tx, private_key)

# send the transaction
tx_hash = w3.eth.sendRawTransaction(signed_tx.rawTransaction)

# wait for the transaction to be mined
receipt = w3.eth.waitForTransactionReceipt(tx_hash)

# print the transaction receipt
print(receipt)
