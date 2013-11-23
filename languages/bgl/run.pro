textElementOfBgl(Text) :-
  parseBgl(Text, _).


parseBgl(Text, Term2) :-
  scannerfullEgl(Text, Term1),
  require(
    bglSubset,
    eglToBgl(Term1, Term2):- interpret(elementOf, [bgl(text)], textElementOfBgl, []).

  ).

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

parseTopDownAndImplode(G, R, I, T2) :-
  parseTopDown(G, R, I, T1),
  implode(T1, T2).
