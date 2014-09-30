% Accept input, non-deterministically and bottom-up
acceptBottomUp(
    grammar([Root|_], Rules), % rules to interpret
    Input % input string of terminals
  ) :-
       acceptBottomUp_(Rules, Root, [], Input).

% Acceptance completed
acceptBottomUp_(_, Root, [n(Root)], []).

% Shift terminal from input to stack
acceptBottomUp_(Rules, Root, Stack, [T|Input0]) :-
  acceptBottomUp_(Rules, Root, [t(T)|Stack], Input0).

% Reduce prefix of stack to according to rule
acceptBottomUp_(Rules, Root, Stack0, Input0) :-
  append(RhsReverse, Stack1, Stack0),
  reverse(RhsReverse, Rhs),
  member(rule(_, N, Rhs), Rules), 
  acceptBottomUp_(Rules, Root, [n(N)|Stack1], Input0).
