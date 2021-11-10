import web3 from "./web3";
import CampaignFactory from "./build/CampaignFactory.json";

const instance = new web3.eth.Contract(
  CampaignFactory.abi,
  "0x7899E41e59d02Bbec9c32A827302CeFe07479C38"
);

export default instance;
