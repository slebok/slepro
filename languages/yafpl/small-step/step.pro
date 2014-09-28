% Simplify condition
step(P, if(E1a, E2, E3), if(E1b, E2, E3)) :-
  step(P, E1a, E1b).

% Commit to then branch
step(_, if(boolconst(true), E, _), E).

% Commit to else branch
step(_, if(boolconst(false), _, E), E).

% Simplify left operand
step(P, op(O, E1a, E2), op(O, E1b, E2)) :-
  step(P, E1a, E1b).

% Simplify right operand
step(P, op(O, E1, E2a), op(O, E1, E2b)) :-
  normal(E1),
  step(P, E2a, E2b).

% Apply operator
step(_, op(O, E1, E2), E0) :-
  normal(E1),
  normal(E2),
  opConst(O, E1, E2, E0).

% Simplify operand of function application
step(P, apply(F, Es1), apply(F, Es4)) :-
  append(Es2, [E1|Es3], Es1),
  map(normal, Es2),
  step(P, E1, E2),
  append(Es2, [E2|Es3], Es4).

% Apply function
step(P, apply(N, Es), E2) :-
  map(normal, Es),
  member((_, (N, Ns, E1)), P),
  zip(Ns, Es, L),
  star(substitute, L, E1, E2).
