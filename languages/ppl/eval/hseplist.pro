% hlist with separator
ppEval(hseplist(B, Bs1), L) :-
  intersperse(B, Bs1, Bs2),
  map(ppEval, Bs2, Ls),
  foldr(happend, [], Ls, L).
