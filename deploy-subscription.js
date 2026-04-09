const hre = require("hardhat");

async function main() {
  const THIRTY_DAYS = 60 * 60 * 24 * 30;
  const PRICE = hre.ethers.parseEther("0.05");

  const Lock = await hre.ethers.getContractFactory("SubscriptionLock");
  const lock = await Lock.deploy("Premium Access", "KEY", PRICE, THIRTY_DAYS);

  await lock.waitForDeployment();
  console.log("Subscription Lock deployed to:", await lock.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
