% Wellness of collection of function declarations
okProg((Fs, E)) :-
  map(toFunName, Fs, Ns),
  set(Ns),
  map(okFun(Fs), Fs),
  okExpr(Fs, [], E, _).

toFunName(((N, _, _), _), N).
