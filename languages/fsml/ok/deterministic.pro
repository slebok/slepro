% Input is handled deterministically
fsmDeterministic(Fsm) :-
  map(stateDeterministic, Fsm).

% Input is handled deterministically in a state
stateDeterministic((_, _, Ts)) :-
  findall(
    I,
    member((I, _, _), Ts),
    Is),
  set(Is).
