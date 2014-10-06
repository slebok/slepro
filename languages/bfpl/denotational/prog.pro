% Evaluate main expression of program
denotational((Fs, E), V) :-
  meaningExpr(Fs, E, F),
  passTo([], F, V).
