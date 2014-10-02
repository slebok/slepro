/*
Map more complex EGL grammar notation to BGL
*/

eglToBgl(Rs1, grammar(Ns2, Rs2)) :-
  map(eglToBglLhs, Rs1, Ns1),
  list_to_set(Ns1, Ns2),
  map(eglToBglRule, Rs1, Rs2).

eglToBglLhs((_, Lhs, _), Lhs).

eglToBglRule(
  ([Label], Lhs, Rhs1),
  rule(Label, Lhs, Rhs2)
) :-
     map(eglToBglSymbol, Rhs1, Rhs2).

eglToBglSymbol(S, S) :-
    S = t(_)
  ; S = n(_). 
