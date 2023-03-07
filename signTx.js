const { ethers } = require('ethers')

async function main() {
  // Connect to Ethereum node

  const provider = new ethers.providers.JsonRpcProvider(
    'https://goerli.base.org'
  )

  // Message to sign
  const message = 'EIP-4844'

  // Private key to sign the message

  const privateKey = 'your_private_key'

  // Hash the message using keccak-256 hash function
  const messageHash = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(message))

  // Sign the message hash using the private key
  const wallet = new ethers.Wallet(privateKey, provider)
  const signature = await wallet.signMessage(ethers.utils.arrayify(messageHash))

  // Convert the signature to hex
  const hexSignature = signature.replace('0x', '')

  console.log('Message:', message)
  console.log('Signature:', signature)

  console.log('hash:', messageHash)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
