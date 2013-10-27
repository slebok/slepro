% An int constant is of the int type
okExpr(_, _, intconst(_), inttype).

% The context provides the type of a variable 
okExpr(_, X, name(N), T) :-
  member((N, T), X).

% Condition is of boolean type; others are of the same type 
okExpr(P, X, if(E1, E2, E3), T) :-
  okExpr(P, X, E1, booltype),
  okExpr(P, X, E2, T),
  okExpr(P, X, E3, T).
 
% Check operator application
okExpr(P, X, op(O, E1, E2), T0) :-
  okExpr(P, X, E1, T1),
  okExpr(P, X, E2, T2),
  okOp(O, T1, T2, T0).

% Check function application
okExpr(P, X, apply(F, Es), T) :-
  map(okExpr(P, X), Es, Ts),
  member(((F, Ts, T), _), P).
