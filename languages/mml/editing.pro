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

% Add a new subobject
addObject(MM1, Id, Key, ClassN, Obj1, Obj3) :-
  newObject_(MM1, ClassN, Obj0),
  topdownGraph(
    addObject_(Id, Key, Obj0),
      Obj1, Obj2),
  graphNf(Obj2, Obj3),
  relaxMetamodel(MM1, MM2),
  require(
    inconsistentAddObject(ClassN),
    conforms(Obj3, MM2)
  ).

% Per-object logic
addObject_(Id, Key, Obj0, Obj1, Obj2) :-
  Obj1 = (Id&_),
  require(
    missingListValueForKey(Key),
    (
      lookup(Key, Obj1, L1),
      list(L1)
    )),
  append(L1, [Obj0], L2),
  update(Key, L2, Obj1, Obj2).

% Remove a subobject
removeObject(MM1, Id, Obj1, Obj3) :-
  topdownGraph(
    removeObject_(Id),
      Obj1, Obj2),
  require(
    missingId(Id),
    Obj1 \= Obj2),
  graphNf(Obj2, Obj3),
  relaxMetamodel(MM1, MM2),
  require(
    inconsistentRemoveObject(Id),
    conforms(Obj3, MM2)
  ).

% Per-object logic
removeObject_(Id, Obj1, Obj2) :-
  graphToList(Obj1, L1, Q),
  append(L2, [(K, V1)|L3], L1),
  append(V2, [(Id&_)|V3], V1),
  append(V2, V3, V4),
  append(L2, [(K, V4)|L3], L4),
  apply(Q, [L4, Obj2]).
