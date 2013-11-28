% Evaluate a text box
ppEval(text(A), [S]) :-
  atom_codes(A, S).
