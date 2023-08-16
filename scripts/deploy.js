const main = async() => {
  const contract = await hre.ethers.deployContract("IntegrityGuard");
  await contract.waitForDeployment();

  console.log("contract address:", contract.target);
};

const runMain = async() => {
  try{
    await main();
  }catch(error){
    console.log(error);
    process.exitCode = 1;
  }
}

runMain();