% All states are reachable from a single initial
fsmReachable(Fsm) :-
  findall(
    Id,
    member((_, Id, _), Fsm),
    Ids),
  findall(
    Initial,
    member((true, Initial, _), Fsm),
    Initials),
  length(Initials, 1),
  fixedPointIds(Fsm, Initials, Reachables),
  setEq(Ids, Reachables).
