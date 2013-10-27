% Page for constructing a new model
new_page(Request) :-

  % Start session
  once((
    repeat,
    sleep(0.01),
    retract(session(S1)),
    S2 is S1 + 1,
    assertz(session(S2))
  )),

  % URL parsing
  member(search(L), Request),
  member((metamodel=MmName), L),
  member((class=CName), L),

  % Object creation
  metamodel(MmName, MM),
  newObject(MM, CName, Obj),
  assertz(state(S1, MmName, Obj)),

  % Page rendering
  editObject(S1).
