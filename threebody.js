import React, { useState, useEffect } from 'react';
import Web3 from 'web3';
import SurvivalGameContract from './SurvivalGameContract.json';
import './App.css';

function App() {
  const [web3, setWeb3] = useState(null);
  const [contract, setContract] = useState(null);
  const [accounts, setAccounts] = useState([]);
  const [techPoints, setTechPoints] = useState(0);
  const [militaryPoints, setMilitaryPoints] = useState(0);
  const [isDaytime, setIsDaytime] = useState(true);

  useEffect(() => {
    const initWeb3 = async () => {
      if (window.ethereum) {
        const web3Instance = new Web3(window.ethereum);
        try {
          await window.ethereum.enable();
          setWeb3(web3Instance);
          const accounts = await web3Instance.eth.getAccounts();
          setAccounts(accounts);
          const networkId = await web3Instance.eth.net.getId();
          const deployedNetwork = SurvivalGameContract.networks[networkId];
          const contractInstance = new web3Instance.eth.Contract(
            SurvivalGameContract.abi,
            deployedNetwork && deployedNetwork.address,
          );
          setContract(contractInstance);
          const techPoints = await contractInstance.methods.getTechnologyPoints().call();
          setTechPoints(techPoints);
          const militaryPoints = await contractInstance.methods.getMilitaryPoints().call();
          setMilitaryPoints(militaryPoints);
          const isDaytime = await contractInstance.methods.isDaytime().call();
          setIsDaytime(isDaytime);
        } catch (error) {
          console.error('Failed to load web3, accounts, or contract', error);
        }
      } else {
        console.log('Please install MetaMask to interact with this dapp!');
      }
    };
    initWeb3();
  }, []);

  const handleTriggerWar = async () => {
    try {
      await contract.methods.triggerWar().send({ from: accounts[0] });
    } catch (error) {
      console.error('Error triggering war:', error);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Survival Game</h1>
        <div>
          <p>Technology Points: {techPoints}</p>
          <p>Military Points: {militaryPoints}</p>
          <p>Daytime: {isDaytime ? 'Yes' : 'No'}</p>
          <button onClick={handleTriggerWar}>Trigger War</button>
        </div>
      </header>
    </div>
  );
}

export default App;
