% atomToRef at metamodel level
atomToRefMM(
  From, % Class that is referring
  To, % Class that is being referred to
  Key, % Key to be updated
  MM1, % Input metamodel
  MM2 % Output metamodel
 ) :- 
      require(
        memberMissing(From, Key),
        lookupMember(From, Key, MM1, X1)),
      require(
        valueMissing,
        lookup(class, X1, value)),
      require(
        atomMissing,
        lookup(type, X1, #atom)),
      update(class, reference, X1, X2),
      update(type, #To, X2, X3),
      updateMember(From, X3, MM1, MM2).
