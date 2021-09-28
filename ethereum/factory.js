import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  CampaignFactory.abi,
  "0xc32f4110847b8D6A092227cA3e0Dd6883669f242"
);

export default instance;
