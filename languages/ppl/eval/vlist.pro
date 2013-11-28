% Vector form of vertical composition
ppEval(vlist(Bs), L) :-
  map(ppEval, Bs, Ls),
  foldr(append, [], Ls, L).
