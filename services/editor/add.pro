% Page for adding a sub-object
add_page(Request) :-

  % URL parsing
  member(search(L), Request),
  member((session=S1), L),
  atom_number(S1, S2),
  member((id=Id1), L),
  atom_number(Id1, Id2),
  member((key=Key), L),
  member((class=ClassN), L),

  % Object creation
  metamodel(MmName, MM),
  retract(state(S2, MmName, Obj1)),
  addObject(MM, Id2, Key, ClassN, Obj1, Obj2),
  assertz(state(S2, MmName, Obj2)),

  % Page rendering
  editObject(S2).
