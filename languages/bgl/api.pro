% BGL-based top-down acceptor for token sequences
bglTopDownAcceptor(File, Input)
 :-
    readTermFile(File, Grammar),
    once(acceptTopDown(Grammar, Input)).

% BGL-based top-down acceptor with scanner
bglTopDownAcceptor(Pred, File, Input1)
 :-
    apply(Pred, [Input1, Input2]),
    bglTopDownAcceptor(File, Input2).

% BGL-based bottom-up acceptor for token sequences
bglBottomUpAcceptor(File, Input)
 :-
    readTermFile(File, Grammar),
    once(acceptBottomUp(Grammar, Input)).

% BGL-based bottom-up acceptor with scanner
bglBottomUpAcceptor(Pred, File, Input1)
 :-
    apply(Pred, [Input1, Input2]),
    bglBottomUpAcceptor(File, Input2).

% BGL-based imploder for parse trees
bglImploder(Input, Output)
 :-
    implode(Input, Output).

% BGL-based exploder for parse trees
bglExploder(File, Input, Output)
 :-
    readTermFile(File, Grammar),
    Grammar = grammar([Root|_], _),
    explode(Grammar, Root, Input, Output).
 
% BGL-based top-down parser for token sequences
bglTopDownParser(File, Text, Term)
 :-
    readTermFile(File, Grammar),
    once(parseTopDown(Grammar, Text, PTree)),
    implode(PTree, Term).

% BGL-based top-down parser with scanner
bglTopDownParser(Pred, File, Text1, Term)
 :-
    apply(Pred, [Text1, Text2]),
    bglTopDownParser(File, Text2, Term).

% Parser of BGL grammars relying on EGL
parserOfBgl(Text, Term2) :-
  require(
    scannerFailed(egl),
    tokens(eglToken, Text, Tokens)),
  File = 'languages/egl/cs.term',
  require(
    fileNotReadable(File),
    readTermFile(File, Egl)),
  require(
    parserFailed(egl),
    scannerfull(fail, Egl, Tokens, Term1)),
  require(
    bglSubset,
    eglToBgl(Term1, Term2)
  ).

% Membership test for BGL by attempted parsing
elementOfBgl(Text) :-
  parserOfBgl(Text, _).
