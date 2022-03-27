
const main = async () => {
  const dropContractFactory = await hre.ethers.getContractFactory('Drop');
  const dropContract = await dropContractFactory.deploy(
    "token id = {id}",
    {
    value:hre.ethers.utils.parseEther('0.00001'),
  },
  );
  await dropContract.deployed()
  console.log('contract address = ',dropContract.address)
  const [owner] = await ethers.getSigners();
  // console.log({a:addressToDrop.address,b:addressToDrop2.address})
  console.log('contract owner = ',await dropContract.owner(),owner.address)
  const uri = await dropContract.uri(1)
  const addressToDrop = {address:"0xFf4240ee0Ccb10C152A725E2B673EBfE8e9A8b00"}
  const dropTxn = await dropContract.deployToken([addressToDrop.address],1000)
  await dropTxn.wait()
  const droppedBalance = await dropContract.balanceOf(addressToDrop.address,1)
  const addressToDrop2 = {address:"0x87711156017e540456343DD99BbbbdB10BC45480"}
  const dropTxn2 = await dropContract.deployToken([addressToDrop2.address],1000)
  await dropTxn2.wait()
  const droppedBalance2 = await dropContract.balanceOf(addressToDrop2.address,1)
  console.log({uri,balanceOfDeployed:droppedBalance,droppedBalance2})
};



const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
