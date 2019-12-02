pragma solidity 0.4.26;

// Smart Contract for the 2019 Blockchain Challenge at Uni Basel
// Case Verein für Vorsorge
// Contributors:
//  Julian Mordig, Alex Walter und Tim Keller

contract OrgaChange {

   // Declaration Start

   struct orga {
       address id;
       string name;
   }
    orga[10] orgas;
    string orgaFrom;
    string orgaTo;
    string orgaNow;
    uint kundeSV;
    uint balance;
    bool orgaChangeStarted;
    // Declaration End


    // -----------

    //Constructor
    constructor() public {

        orgas[0].name = "Freizügigkeitsstiftung 1";
        orgas[1].id = 0x2153F81fCFf291eC701A07647F81012ebd8A0f94;
        orgas[1].name = "Freizügigkeitsstiftung 2";
        orgas[2].id = 0xb6bBE3d6C76aE14c6B3A17DEaB98C9b17A612983;
        orgas[2].name = "Freizügigkeitsstiftung 3";
        orgas[3].id = 0x3a51f2Fe69Ae57BF59B8056893c610B8Bd187708;
        orgas[3].name = "Freizügigkeitsstiftung 4";
        orgas[4].id = 0x0E2dDfF7E2aE03F51415C1fFEe20c7ABd8760Fbd;
        orgas[4].name = "Freizügigkeitsstiftung 5";
        orgas[5].id = 0xa3fe2eB0fa8bd67c5B2De91190B6F08554ad03D1;
        orgas[5].name = "Pensionskasse 1";
        orgas[6].id = 0xEab0Ec9de88C6B918Ba18618B39A667acC4C5CE0;
        orgas[6].name = "Pensionskasse 2";
        orgas[7].id = 0x18a3981B30D5A761242BAfcbF523816039D0b375;
        orgas[7].name = "Pensionskasse 3";
        orgas[8].id = 0x46DcE446AFf362349443dDCF2e1400B6c4e4C4EA;
        orgas[8].name = "Pensionskasse 4";
        orgas[9].id = 0xfbCc0103515e776BAdBC292Fb8ca02Df696E6f87;
        orgas[9].name = "Pensionskasse 5";
        orgaChangeStarted = false;
    }


    // Modifiers Start
    modifier OrgaChangeNotActive() {
        require(orgaChangeStarted == false, "Organization Change is already in progress!");
        _;
    }

    modifier OrgaChangeInProgress() {
        require(orgaChangeStarted == true, "Organization Change was not started yet!");
        _;
    }
    
    modifier OrgaInNetwork(string _orga) {
        require(orgaIsPart(_orga),"The Organization you choose is not part of the network");
        _;
    }

    modifier OnlyOrgas(){
        require(addressIsPart(msg.sender),"You are not allowed to trigger that function");
        _;
    }

    modifier NoOrgas(){
        require(!addressIsPart(msg.sender),"You are not allowed to trigger that function");
        _;
    }
    // Modifiers End

    // Functions Start
    function startOrgaChange(string _orgaFrom, uint _kundeSV, uint _balance) public OnlyOrgas OrgaChangeNotActive OrgaInNetwork(_orgaFrom) {
        orgaFrom = _orgaFrom;
        orgaNow = orgaFrom;
        kundeSV = _kundeSV;
        balance = _balance;
        orgaChangeStarted = true;
    }

    function getOrga(string _orgaTo) public NoOrgas OrgaChangeInProgress OrgaInNetwork(_orgaTo) {
        require(orgaIsPart(_orgaTo),"The Organization you choose is not part of the network");
        if (orgaIsPart(_orgaTo)) {
        orgaTo = _orgaTo;
        finishOrgaChange();
        }
    }

    function finishOrgaChange() private {
        if (getID()) {
            orgaNow = orgaTo;
        }
        orgaChangeStarted = false;
    }

    function orgaIsPart(string _orga) public returns (bool) {
        uint arrayLength = orgas.length;
        for(uint i = 0;i < arrayLength; i++){
            if(keccak256(abi.encodePacked((_orga))) == keccak256(abi.encodePacked((orgas[i].name)))){
                return true;
            }
        }
        return false;
    }

    function addressIsPart(address _address) public returns (bool) {
        uint arrayLength = orgas.length;
        for(uint i = 0;i < arrayLength; i++){
            if( _address == orgas[i].id){
                return true;
            }
        }
        return false;
    }
    // Functions End

    // Public Getters Start

    function getCurrentOrga() public view returns (string) {
        return orgaNow;
    }
    // Public Getters End
    // Private Getters Start
    // Dummy-Funktion, welche die zukünftige Funktionalität mit einer externen Identifizierung repräsentiert.
    function getID() private view returns (bool) {
        return true;
    }
    // Private Getters End
}