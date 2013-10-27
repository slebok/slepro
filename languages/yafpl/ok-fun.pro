% Check function
okFun(P, ((N, Ts, T), (N, Ns, E))) :-
  set(Ns),
  zip(Ns, Ts, X),
  okExpr(P, X, E, T).

