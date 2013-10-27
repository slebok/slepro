% Page for removing a sub-object
remove_page(Request) :-

  % URL parsing
  member(search(L), Request),
  member((session=S1), L),
  atom_number(S1, S2),
  member((id=Id1), L),
  atom_number(Id1, Id2),

  % Object creation
  metamodel(MmName, MM),
  retract(state(S2, MmName, Obj1)),
  removeObject(MM, Id2, Obj1, Obj2),
  assertz(state(S2, MmName, Obj2)),

  % Page rendering
  editObject(S2).
