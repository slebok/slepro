% Wellness of FSMs
okFsm(Fsm) :-
  require(fsmDistinctIds(Fsm)),
  require(fsmResolvable(Fsm)),
  require(fsmDeterministic(Fsm)),
  require(fsmReachable(Fsm)).
