import { useEffect, useState } from 'react'
import { ethers } from 'ethers'

// Components
import Navigation from './components/Navigation'
import Section from './components/Section'
import Product from './components/Product'

// ABIs
import Dappazon from './abis/Dappazon.json'

// Config
import config from './config.json'



function App() {
  const [account, setAccount] = useState(null)
  const [provider, Setprovider] = useState(null)
  const [dappazon, setDappazon] = useState(null)

  const loadBlockchain = async () => {
    //Connect to Blockchain
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    Setprovider(provider)
    console.log('Loading......')

    const network = await provider.getNetwork()
    console.log(network)

    //Connect to smart contracts (Create JS Versions)
    const dappazon = new ethers.Contract(
      config[network.chainId].dappazon.address,
      Dappazon,
      provider
    )
    setDappazon(dappazon)
      const items = []
      for (var i =0; i < 9; i++) {
        const item = await dappazon.items(i + 1)
        items.push(item)
      }
      

  }

  useEffect(()=> {
    loadBlockchain()
  },[])

  return (
    <div>
      <Navigation account={account} setAccount={setAccount} />
      <h2>Welcome to Dappazon</h2>

    </div>
  );
}

export default App;
