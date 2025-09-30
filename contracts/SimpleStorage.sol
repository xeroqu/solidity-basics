// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {
    uint256 favoriteNumber;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // Person public pat = Person({favoriteNumber:2, name: 'Malik'});

    Person[] public listPeople;
    mapping(string => uint256) public nameFavoriteNumber;
    
    
    function store(uint256 _favoriteNumber) public virtual  {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(uint256 _favoriteNumber, string memory _name) public {
        listPeople.push(Person(_favoriteNumber, _name));
        nameFavoriteNumber[_name] = _favoriteNumber;
    }


}
