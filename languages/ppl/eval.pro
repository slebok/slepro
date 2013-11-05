% Evaluate a text box
ppEval(text(A), [S]) :-
  atom_codes(A, S).

% Evaluate an empty box
ppEval(empty, []).

% Evaluate a vertical composition
ppEval(vbox(B1, B2), L3) :-
  ppEval(B1, L1),
  ppEval(B2, L2),
  append(L1, L2, L3).

% Vector form of vertical composition
ppEval(vlist(Bs), L) :-
  map(ppEval, Bs, Ls),
  foldr(append, [], Ls, L).

% Evaluate a horizontal composition
ppEval(hbox(B1, B2), L3) :-
  ppEval(B1, L1),
  ppEval(B2, L2),
  happend(L1, L2, L3).

% Vector form of horizontal composition
ppEval(hlist(Bs), L) :-
  map(ppEval, Bs, Ls),
  foldr(happend, [], Ls, L).

% hlist with separator 
ppEval(hseplist(B, Bs1), L) :-
  intersperse(B, Bs1, Bs2),
  map(ppEval, Bs2, Ls),
  foldr(happend, [], Ls, L).

% Apply indentation
ppEval(indent(B), L) :-
  ppEval(hbox(text(' '), B), L).

% Failure of rendering
ppEval(B, _) :-
  format('Rendering failed: ~w~n', [B]),
  fail.

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
