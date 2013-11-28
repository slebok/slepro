% Evaluate a vertical composition
ppEval(vbox(B1, B2), L3) :-
  ppEval(B1, L1),
  ppEval(B2, L2),
  append(L1, L2, L3).
