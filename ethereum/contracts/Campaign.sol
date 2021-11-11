//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract CampaignFactory {
    
    Campaign[] public deployedCampaigns;

    function createCampaign(uint256 minimum, string memory description) public {
        Campaign newCampaign = new Campaign(minimum, description, msg.sender);

        deployedCampaigns.push(newCampaign);
    }

    function getDeployedCampaigns() public view returns (Campaign[] memory) {
        return deployedCampaigns;
    }
}

contract Campaign {
    
    address public manager;
    uint256 public minimumContribution;
    string public campaignDescription;
    uint256 public approversCount;
    uint public requestCount;
    
    mapping(address => bool) public approvers;
    mapping(uint => Request) public requests;
    
    struct Request {
        string description;
        uint256 value;
        address payable recipient;
        bool isCompleted;
        uint256 approvalCount;
        mapping(address => bool) approvals;
    }
    
    event Contribution(address _sender, uint _value);
    event RequestCreated(uint _id, string _description, uint _value, address _recipient);
    event RequestApproved(uint _id, address _sender);
    event RequestFinalized(uint _id);

    modifier restricted() {
        require(msg.sender == manager, "Restricted access, manager only");
        _;
    }

    constructor(uint256 _minimum, string memory _description, address _creator) {
        manager = _creator;
        minimumContribution = _minimum;
        campaignDescription = _description;
    }

    function contribute() public payable {
        require(msg.value > minimumContribution, "Amount too low");

        approvers[msg.sender] = true;
        approversCount++;
        
        emit Contribution(msg.sender, msg.value);
    }

    function createRequest(
        string memory _description,
        uint256 _value,
        address payable _recipient
    ) public restricted {
        Request storage newRequest = requests[requestCount];
        requestCount++;
        
        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.isCompleted = false;
        newRequest.approvalCount = 0;
        
        emit RequestCreated(requestCount, _description, _value, _recipient );
    }

    function approveRequest(uint256 _index) public {
        Request storage request = requests[_index];

        require(approvers[msg.sender], "You're not the contributor");
        require(!request.approvals[msg.sender], "You've already approved the request");

        request.approvals[msg.sender] = true;
        request.approvalCount++;
        
        emit RequestApproved(_index, msg.sender );
    }

    function finalizeRequest(uint256 _index) public restricted {
        Request storage request = requests[_index];

        require(request.approvalCount > (approversCount / 2), "At least 50% of the contributors need to approve the request");
        require(!request.isCompleted, "The request has already been completed");

        request.recipient.transfer(request.value);
        request.isCompleted = true;
        
        emit RequestFinalized(_index);
    }

    function getSummary()
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            address,
            string memory
        )
    {
        return (
            minimumContribution,
            address(this).balance,
            requestCount,
            approversCount,
            manager,
            campaignDescription
        );
    }

    function getRequestsCount() public view returns (uint256) {
        return requestCount;
    }
}
