pragma solidity 0.4.26;

// Smart Contract for the 2019 Blockchain Challenge at Uni Basel
// Case Verein für Vorsorge
// Contributors:
//  Julian Mordig, Alex Walter und Tim Keller

contract OrgaChange {

   // Declaration Start

   struct orga {
       uint id;
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
        orgas[1].id = 2;
        orgas[1].name = "Freizügigkeitsstiftung 2";
        orgas[2].id = 3;
        orgas[2].name = "Freizügigkeitsstiftung 3";
        orgas[3].id = 4;
        orgas[3].name = "Freizügigkeitsstiftung 4";
        orgas[4].id = 5;
        orgas[4].name = "Freizügigkeitsstiftung 5";
        orgas[5].id = 1;
        orgas[5].name = "Pensionskasse 1";
        orgas[6].id = 2;
        orgas[6].name = "Pensionskasse 2";
        orgas[7].id = 3;
        orgas[7].name = "Pensionskasse 3";
        orgas[8].id = 4;
        orgas[8].name = "Pensionskasse 4";
        orgas[9].id = 5;
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
    // Modifiers End

    // Functions Start
    function startOrgaChange(string _orgaFrom, uint _kundeSV, uint _balance) public OrgaChangeNotActive OrgaInNetwork(_orgaFrom) {
        orgaFrom = _orgaFrom;
        orgaNow = orgaFrom;
        kundeSV = _kundeSV;
        balance = _balance;
        orgaChangeStarted = true;
    }

    function getOrga(string _orgaTo) public OrgaChangeInProgress OrgaInNetwork(_orgaTo) {
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