import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  CampaignFactory.abi,
  "0x0445A7037983E2557345b368ccD2065b751EDdaB"
);

export default instance;
