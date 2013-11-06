% All states are reachable from the initial state
fsmReachable(Fsm) :-
  findall(
    Id,
    member((_, Id, _), Fsm),
    Ids),
  findall(
    Initial,
    member((true, Initial, _), Fsm),
    Initials),
  fixedPointIds(Fsm, Initials, Reachables),
  setEq(Ids, Reachables).
