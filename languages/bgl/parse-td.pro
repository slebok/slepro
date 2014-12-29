% Parse input top-down
parseTopDown(Rules, Input, Tree) :-
    Rules = [(_, Root, _)|_],
    parseTopDown(Rules, n(Root), Tree, Input, []).

% Consume terminal at top of stack from input
parseTopDown(_, t(T), leaf(T), [T|Input], Input).

% Expand nonterminal at the top of stack
parseTopDown(Rules, n(N), fork(Rule, Trees), Input0, Input1) :-
    member(Rule, Rules),
    Rule = (_, N, Rhs),
    parseTopDown(Rules, Rhs, Trees, Input0, Input1).

% Parsing completed
parseTopDown(_, [], [], Input, Input).

% Parse symbol by symbol
parseTopDown(Rules, [Symbol|Symbols], [Tree|Trees], Input0, Input2) :-
    parseTopDown(Rules, Symbol, Tree, Input0, Input1),
    parseTopDown(Rules, Symbols, Trees, Input1, Input2).
