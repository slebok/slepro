% Parse input, non-deterministically and top-down
parseTopDown(
    grammar([Root|_], Rules), % rules to interpret
    Input, % input string of terminals
    Tree % parse tree
  ) :-
    parseTopDown_(Rules, n(Root), Tree, Input, []).

% Consume terminal at top of stack from input
parseTopDown_(_, t(T), leaf(T), [T|Input], Input).

% Expand nonterminal at top of stack
parseTopDown_(Rules, n(N), fork(Rule,Trees1), Input0, Input1) :-
  member(Rule, Rules),
  Rule = rule(_, N, Rhs),
  seq(parseTopDown_(Rules), Rhs, Trees1, Input0, Input1).
