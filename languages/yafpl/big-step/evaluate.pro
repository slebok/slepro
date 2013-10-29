% A constant evaluates to itself
evaluate(_, _, intconst(I), intval(I)).

% A variable evaluates to its binding
evaluate(_, X, name(N), V) :-
  member((N, V), X).

% True condition
evaluate(P, X, if(E1, E2, _), V) :-
  evaluate(P, X, E1, boolval(true)),
  evaluate(P, X, E2, V).

% False condition
evaluate(P, X, if(E1, _, E2), V) :-
  evaluate(P, X, E1, boolval(false)),
  evaluate(P, X, E2, V).
 
% Evaluate operator application
evaluate(P, X, op(O, E1, E2), V0) :-
  evaluate(P, X, E1, V1),
  evaluate(P, X, E2, V2),
  opVal(O, V1, V2, V0).

% Evaluate function application
evaluate(P, X1, apply(N, Es), V) :-
  map(evaluate(P, X1), Es, Vs),
  member((_, (N, Ns, E)), P),
  zip(Ns, Vs, X2),
  evaluate(P, X2, E, V).
