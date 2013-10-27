% Accept input, non-deterministically and bottom-up
acceptBottomUp(
    grammar(_, Rules), % rules to interpret
    Root, % root nonterminal
    Input % input string of terminals
  ) :-
       acceptBottomUp_(Rules, [], [n(Root)], Input).

% Acceptance completed
acceptBottomUp_(_, Stack, Stack, []).

% Shift terminal from input to stack
acceptBottomUp_(Rules, Stack0, Stack1, [T|Input0]) :-
  acceptBottomUp_(Rules, [t(T)|Stack0], Stack1, Input0).

% Reduce prefix of stack to according to rule
acceptBottomUp_(Rules, Stack0, Stack2, Input0) :-
  append(RhsReverse, Stack1, Stack0),
  reverse(RhsReverse, Rhs),
  member(rule(_, N, Rhs), Rules), 
  acceptBottomUp_(Rules, [n(N)|Stack1], Stack2, Input0).
