% Reflexive case
reduce(_, E, E) :-
  normal(E).

% Transitive case
reduce(P, E1, E3) :-
  step(P, E1, E2),
  reduce(P, E2, E3).
