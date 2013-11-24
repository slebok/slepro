eglElementOf(Mapping, FileCs, FileLs, Text) :-
  eglParse(layout, Mapping, FileCs, FileLs, Text, _).
eglElementOf(Layout, Mapping, FileCs, FileLs, Text) :-
  eglParse(Layout, Mapping, FileCs, FileLs, Text, _).
eglParse(Layout, Mapping, FileCs, FileLs, Text, Term) :-
  readTermFile(FileCs, CfSyn),  
  readTermFile(FileLs, LexSyn),
  CfSyn = [(_,Root,_)|_],
  scannerlessParser(CfSyn, Root, LexSyn, Layout, Mapping, Text, Term).

textElementOfEgl(Text) :-
  parseEgl(Text, _).

parseEgl(Text, Term) :-
  scannerfullEgl(Text, Term).

scannerfullEgl(Text, Term) :-
  require(
    scannerFailed(egl),
    tokens(eglToken, Text, Tokens)),
  File = 'languages/egl/cs.term',
  require(
    fileNotReadable(File),
    readTermFile(File, Egl)),
  require(
    parserFailed(egl),
    scannerfullParser(Egl, grammar, fail, Tokens, Term)).

scannerlessEgl(Text, Term) :-
  File1 = 'languages/egl/cs.term',
  require(
    fileNotReadable(File1),
    readTermFile(File1, Consyn)),
  File2 = 'languages/egl/ls.term',
  require(
    fileNotReadable(File2),
    readTermFile(File2, Lexsyn)),
  require(
    parserFailed(egl),
    scannerlessParser(Consyn, grammar, Lexsyn, layout, eglMapping, Text, Term)).

% Scannerfull parser construction
scannerfullParser(
    CfSyn, % context-free syntax
    Root, % root nonterminal
    Mapping, % tree mapping
    Input0, % input string of terminals
    Tree % parse tree
  ) :-
       Config = (
         CfSyn,
         scannerfullTerminal,
         scannerfullLexical,
         Mapping
       ),
       xparse(Config, n(Root), [Tree], Input0, []).
 
% Handle terminals as tokens previously scanned
scannerfullTerminal(T, [T|Input], Input).

% Handle external nonterminals as token class
scannerfullLexical(N, V, [T|Input], Input) :-
  T =.. [N, V].

% Scannerless parser construction
scannerlessParser(
    CfSyn, % rules of context-free syntax
    Root, % root nonterminal
    LexSyn, % rules of lexical syntax
    Layout, % layout nonterminal
    Mapping, % tree mapping
    Input0, % input string of terminals
    Tree % parse tree
  ) :-
       Config = (
         CfSyn,
         scannerlessTerminal(LexSyn, Layout, Mapping),
         scannerlessLexical(LexSyn, Layout, Mapping),
         Mapping
       ),
       xparse(Config, n(Root), [Tree], Input0, Input1),
       skipLayout(LexSyn, Layout, Mapping, Input1, []).

% Handle terminals as prefixes of the input (and skip layout)
scannerlessTerminal(LexSyn, Layout, Mapping, T, Input0, Input2) :-
  skipLayout(LexSyn, Layout, Mapping, Input0, Input1),
  scannerlessTerminal(T, Input1, Input2).

% Handle terminals as prefixes of the input
scannerlessTerminal(T, Input0, Input1) :-
  name(T, String),
  append(String, Input1, Input0).

% Parse nonterminals according to lexical syntax
scannerlessLexical(LexSyn, Layout, Mapping, N, Tree, Input0, Input2) :-
  skipLayout(LexSyn, Layout, Mapping, Input0, Input1),
  parseLexical(LexSyn, Mapping, n(N), [Tree], Input1, Input2).

% Skip layout
skipLayout(LexSyn, Layout, Mapping, Input0, Input1) :- 
  parseLexical(LexSyn, Mapping, star([n(Layout)]), _, Input0, Input1).

% Parse symbols according to lexical syntax
parseLexical(LexSyn, Mapping, Symbol, Trees, Input0, Input1) :-
  Config = (
    LexSyn,
    scannerlessTerminal,
    scannerlessChar,
    Mapping
  ),
  once(xparse(Config, Symbol, Trees, Input0, Input1)).

% Parse externals of lexical syntax as char constraints
scannerlessChar(N, Char, Input0, Input1) :-
  char(N, Char, Input0, Input1).
