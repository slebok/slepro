% BGL-based top-down acceptor for token sequences
bglTopDownAcceptor(Root, File, Input)
 :-
    readTermFile(File, Grammar),
    once(acceptTopDown(Grammar, Root, Input)).

% BGL-based top-down acceptor with scanner
bglTopDownAcceptor(Pred, Root, File, Input1)
 :-
    apply(Pred, [Input1, Input2]),
    bglTopDownAcceptor(Root, File, Input2).

% BGL-based bottom-up acceptor for token sequences
bglBottomUpAcceptor(Root, File, Input)
 :-
    readTermFile(File, Grammar),
    once(acceptBottomUp(Grammar, Root, Input)).

% BGL-based bottom-up acceptor with scanner
bglBottomUpAcceptor(Pred, Root, File, Input1)
 :-
    apply(Pred, [Input1, Input2]),
    bglBottomUpAcceptor(Root, File, Input2).

% BGL-based imploder for parse trees
bglImploder(Input, Output)
 :-
    implode(Input, Output).

% BGL-based exploder for parse trees
bglExploder(Root, File, Input, Output)
 :-
    readTermFile(File, Grammar),
    explode(Grammar, Root, Input, Output).
 
% BGL-based top-down parser for token sequences
bglTopDownParser(Root, File, Text, Term)
 :-
    readTermFile(File, Grammar),
    once(parseTopDown(Grammar, Root, Text, PTree)),
    implode(PTree, Term).

% BGL-based top-down parser with scanner
bglTopDownParser(Pred, Root, File, Text1, Term)
 :-
    apply(Pred, [Text1, Text2]),
    bglTopDownParser(Root, File, Text2, Term).

% More helpers for BGL
elementOfBgl(Text) :-
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
