pragma solidity ^0.4.8;

contract People {

  //defines an array with the Person struct inside of it

  Person[] public people;

  struct Person {
    // strings must be fixed length to fit into array solidity quirk
    bytes32 firstName;
    bytes32 lastName;
    uint age;
  }

  function addPerson(bytes32 _firstName, bytes32 _lastName, uint _age) returns (bool success) {

    //carving out some memory for struct? read 'memory' in docs
    Person memory newPerson;
    newPerson.firstName = _firstName;
    newPerson.lastName = _lastName;
    newPerson.age = _age;

    people.push(newPerson);
    return true;
  }

  function getPeople() constant returns (bytes32[],bytes32[],uint[]) {
    
    uint length = people.length;

    //storage pointers
    bytes32[] memory firstNames = new bytes32[](length);
    bytes32[] memory lastNames =  new bytes32[](length);
    uint[] memory ages = new uint[](length);
    
    for (uint i = 0; i < people.length; i++) {
      Person memory currentPerson;
      currentPerson = people[i];
      firstNames[i] = currentPerson.firstName;
      lastNames[i] = currentPerson.lastName;
      ages[i] = currentPerson.age;
    }
       return (firstNames, lastNames, ages);
  }

}



//Dont use Call to get people or add people!!
//Do Like this
//People.deployed().then(instance => instance.addPerson("dylan", "avery", 32)).then(result => console.log(result))
//People.deployed().then(instance => instance.getPeople()).then(result => console.log(result))
