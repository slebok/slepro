% The case for terminals
xparse(Config, t(T), [], Input0, Input1) :-
  Config = (_, ParseTerminal, _, _),
  apply(ParseTerminal, [T, Input0, Input1]).

% The case for nonterminals
xparse(
    Config,
    n(N),
    [Tree2],
    Input0, Input1
  ) :-
       Config = (Rules, _, _, Mapping),
       member(Rule1, Rules),
       Rule1 = (LOpt, N, Rhs),
       xparseSeq(Config, Rhs, Trees1, Input0, Input1),
       (
         % Use label when available
         LOpt = [L],
         Tree1 =.. [L|Trees1]
       ; 
         % Use trees as is for nonterminal with one rule
         LOpt = [],
         \+ ( member(Rule2, Rules), 
              Rule2 = (_, N, _),
              Rule1 \= Rule2 ),
         list2tuple([], Trees1, Tree1) 
       ),
       ( apply(Mapping, [N, Tree1, Tree2]) -> 
             true
           ; Tree1 = Tree2 ). 

% The case for external nonterminals
xparse(Config, n(N), [Tree], Input0, Input1) :-
  Config = (Rules, _, ParseExternal, _),
  \+ member((_, N, _), Rules),
  apply(ParseExternal, [N, Tree, Input0, Input1]).

% "*" / "+" / "?"
xparse(
    Config,
    EbnfSymbol,
    [Trees2],
    Input0, Input1
  ) :-
       EbnfSymbol =.. [Func,Symbols],
       member(Func, [star, plus, option]),
       Pred = xparseSeq(Config, Symbols),
       Goal =.. [Func, Pred, Trees1, Input0, Input1],
       Goal,
       concat(Trees1, Trees2).

% Parse groups (sequences) of symbols
xparseSeq(
    Config,
    Symbols,
    Trees2,
    Input0, Input1
  ) :-
       seq(xparse(Config), Symbols, Trees1, Input0, Input1),
       concat(Trees1, Trees2).
