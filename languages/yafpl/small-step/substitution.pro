% Substitution
substitute(_, intconst(I), intconst(I)).
substitute(_, boolconst(B), boolconst(B)).
substitute(_, boolconst(B), boolconst(B)).
substitute((N,E), name(N), E).
substitute((N1,_), name(N2), name(N2)) :- N1 \= N2.
substitute(S, if(E1a, E2a, E3a), if(E1b, E2b, E3b)) :-
  substitute(S, E1a, E1b),
  substitute(S, E2a, E2b),
  substitute(S, E3a, E3b).
substitute(S, op(O, Left1, Right1), op(O, Left2, Right2)) :-
  substitute(S, Left1, Left2),
  substitute(S, Right1, Right2).
substitute(S, apply(F, Es1), apply(F, Es2)) :-
  map(substitute(S), Es1, Es2).
