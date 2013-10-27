% Check program (i.e., a collection of function declarations)
okProg(P) :-
  map(toFunName, P, Ns),
  set(Ns),
  map(okFun(P), P).

toFunName(((N, _, _), _), N).
