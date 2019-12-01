pragma solidity 0.4.26;

// Smart Contract for the 2019 Blockchain Challenge at Uni Basel
// Case Verein für Vorsorge
// Contributors:
//  Julian Mordig, Alex Walter und Tim Keller

contract OrgaChange {
   
   // Declaration Start
    uint[2] fs_orga;
    uint[2] pk_orga;
    uint private orgaFrom;
    uint orgaTo;
    uint orgaNow;
    uint kundeSV;
    uint balance;

    // Declaration End


    // -----------

    //Constructor
    constructor() public {
        fs_orga[0] = 0;
        fs_orga[1] = 1;

    }


    // Modifiers Start

    // Modifiers End

    // Functions Start
    function startOrgaChange(uint _orgaFrom, uint _kundeSV, uint _balance) public {
        orgaFrom = _orgaFrom;
        orgaNow = orgaFrom;
        kundeSV = _kundeSV;
        balance = _balance;

    }

    function getOrga(uint _orgaTo) public {
        orgaTo = _orgaTo;
        finishOrgaChange();
    }

    function finishOrgaChange() private {
        orgaNow = orgaTo;
    }

    // Functions End

    // Public Getters Start

    function getCurrentOrga() public view returns (uint) {
        return orgaNow;
    }
    // Public Getters End
}