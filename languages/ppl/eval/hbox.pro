% Evaluate a horizontal composition
ppEval(hbox(B1, B2), L3) :-
  ppEval(B1, L1),
  ppEval(B2, L2),
  happend(L1, L2, L3).

% Horizontal composition of boxes (consisting of many lines)
happend(L1, L2, L3) :-
  map(length, L1, Lens),
  foldr(max, 0, Lens, Len),
  repeat(0' , Len, Spaces),
  happend(Spaces, L1, L2, L3).

% Helper for happend/3
happend(_, [], [], []).
happend(Spaces, [H1|T1], [H2|T2], [H3|T3]) :-
  append(H1, H2, H3),
  happend(Spaces, T1, T2, T3).
happend(_, [H1|T1], [], [H1|T1]).
happend(Spaces, [], [H2|T2], [H3|T3]) :-
  append(Spaces, H2, H3),
  happend(Spaces, [], T2, T3).
