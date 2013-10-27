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
