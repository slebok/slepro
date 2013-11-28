% Vector form of horizontal composition
ppEval(hlist(Bs), L) :-
  map(ppEval, Bs, Ls),
  foldr(happend, [], Ls, L).
