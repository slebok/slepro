% Wellness of FSMs
okFsm(Fsm) :-
  require(fsmSingleInitial(Fsm)),
  require(fsmDistinctIds(Fsm)),
  require(fsmResolvable(Fsm)),
  require(fsmDeterministic(Fsm)),
  require(fsmReachable(Fsm)).
