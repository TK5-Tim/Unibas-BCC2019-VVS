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
    orga[5] fs_orga;
    orga[5] pk_orga;
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
        fs_orga[0].id = 1;
        fs_orga[0].name = "Freizügigkeitsstiftung 1";
        fs_orga[1].id = 2;
        fs_orga[1].name = "Freizügigkeitsstiftung 2";
        fs_orga[2].id = 3;
        fs_orga[2].name = "Freizügigkeitsstiftung 3";
        fs_orga[3].id = 4;
        fs_orga[3].name = "Freizügigkeitsstiftung 4";
        fs_orga[4].id = 5;
        fs_orga[5].name = "Freizügigkeitsstiftung 5";
        pk_orga[0].id = 1;
        pk_orga[0].name = "Pensionskasse 1";
        pk_orga[1].id = 2;
        pk_orga[1].name = "Pensionskasse 2";
        pk_orga[2].id = 3;
        pk_orga[2].name = "Pensionskasse 3";
        pk_orga[3].id = 4;
        pk_orga[3].name = "Pensionskasse 4";
        pk_orga[4].id = 5;
        pk_orga[4].name = "Pensionskasse 5";
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
    // Modifiers End

    // Functions Start
    function startOrgaChange(string _orgaFrom, uint _kundeSV, uint _balance) public OrgaChangeNotActive {
        orgaFrom = _orgaFrom;
        orgaNow = orgaFrom;
        kundeSV = _kundeSV;
        balance = _balance;
        orgaChangeStarted = true;
    }

    function getOrga(string _orgaTo) public OrgaChangeInProgress {
        orgaTo = _orgaTo;
        finishOrgaChange();
    }

    function finishOrgaChange() private {
        if (getID()) {
            orgaNow = orgaTo;
        }
        orgaChangeStarted = false;
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