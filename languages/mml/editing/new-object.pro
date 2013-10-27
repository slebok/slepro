% Instantiate a class
newObject(MM1, ClassN, Obj2) :-
  newObject_(MM1, ClassN, Obj1),
  graphNf(Obj1, Obj2),
  relaxMetamodel(MM1, MM2),
  require(
    inconsistentNewObject(ClassN),
    conforms(Obj2, MM2)
  ).

% Instantiation helper
newObject_(MM, ClassN, Obj) :-
  lookupConcreteClass(ClassN, MM, Class),
  lookup(members, Class, Ms),
  map(newMember, Ms, Fs),
  listToGraph([(class, ClassN)|Fs], Obj).

% Per-member logic
newMember(Member, (MemberN, [])) :-
  lookup(name, Member, MemberN).
