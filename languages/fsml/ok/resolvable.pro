% All state ids are resolvable to states
fsmResolvable(Fsm) :-
  findall(
    DefId,
    member((_, DefId, _), Fsm),
    DefIds),
  findall(
    RefId,
    ( 
      member((_, _, Ts), Fsm),
      member((_, _, RefId), Ts)
    ),
    RefIds),
  subset(RefIds, DefIds).
