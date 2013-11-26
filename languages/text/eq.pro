% Equivalence of text encoded as lists codes
textEq(X,X).
textEq(X,Y) :-
  length(X, L1),
  length(Y, L2),
  % Ignore difference regarding final "newline"
  ( L1 is L2 + 1, append(Y, [10], X)
  ; L2 is L1 + 1, append(X, [10], Y) ).
