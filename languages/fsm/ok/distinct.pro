% All state ids are distinct
fsmDistinctIds(Fsm) :-
  findall(
    Id,
    member((_, Id, _), Fsm),
    Ids),
  set(Ids).
