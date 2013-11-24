bglElementOf(File, I) :-
  bglParse(File, I, _).
bglParse(File, I, T) :-
  readTermFile(File, G),  
  G = grammar([R|_], _),
  parseTopDownAndImplode(G, R, I, T).

% Turn string into list of singleton character atoms
charsToTokens(String1, L2) :-
  append(String2, [10], String1),
  map(singleton, String2, L1),
  map(flip(atom_codes), L1, L2).

textElementOfBgl(Text) :-
  parseBgl(Text, _).

parseBgl(Text, Term2) :-
  scannerfullEgl(Text, Term1),
  require(
    bglSubset,
    eglToBgl(Term1, Term2)
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
