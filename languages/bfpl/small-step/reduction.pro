% Evaluate main expression of program
smallStep((Fs, E1), E2) :-
  reduce(Fs, E1, E2).

% Reflexive case
reduce(_, E, E) :-
  normal(E).

% Transitive case
reduce(Fs, E1, E3) :-
  step(Fs, E1, E2),
  reduce(Fs, E2, E3).
