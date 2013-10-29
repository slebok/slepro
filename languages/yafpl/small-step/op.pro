opConst(add, intconst(X1), intconst(X2), intconst(X0)) :-
  X0 is X1 + X2.

opConst(sub, intconst(X1), intconst(X2), intconst(X0)) :-
  X0 is X1 - X2.

opConst(mult, intconst(X1), intconst(X2), intconst(X0)) :-
  X0 is X1 * X2.

opConst(eq, intconst(X1), intconst(X2), boolconst(X0)) :-
  toBoolean((X1==X2), X0).
