meaningProg(
  P, % Program
  E, % Expression
  V % Result
) :-
     meaningExpr(P, E, F),
     passTo([], F, V).
