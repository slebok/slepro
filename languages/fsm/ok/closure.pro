% Compute closure of state reachable
fixedPointIds(Fsm, Ids1, Ids4) :-
  findall(
    Id2,
    (
      member(Id1, Ids1),
      member((_, Id1, Ts), Fsm),
      member((_, _, Id2), Ts)
    ),
    Ids2),
  union(Ids1, Ids2, Ids3),
  ( \+ setEq(Ids1, Ids3) ->
        fixedPointIds(Fsm, Ids3, Ids4)
      ; Ids4 = Ids1
  ).
