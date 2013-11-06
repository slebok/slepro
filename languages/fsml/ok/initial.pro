% There is a single initial state
fsmSingleInitial(Fsm) :-
  findall(
    Initial,
    member((true, Initial, _), Fsm),
    Initials),
  length(Initials, 1).
