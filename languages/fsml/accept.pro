% Simulation while ignoring output
acceptFsm(Fsm, Input) :-
  simulateFsm(Fsm, Input, _).
