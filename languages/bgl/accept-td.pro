% Accept input, non-deterministically and top-down
acceptTopDown(
    grammar(_, Rules), % rules to interpret
    Root, % root nonterminal
    Input % input string of terminals
  ) :- 
       acceptTopDown_(Rules, [n(Root)], Input).

% Acceptance completed
acceptTopDown_(_, [], []).

% Consume terminal at top of stack from input
acceptTopDown_(
    Rules,
    [t(T)|Stack], % parser stack with terminal at the top
    [T|Input] % input with ditto terminal as head
  ) :-
       acceptTopDown_(Rules, Stack, Input).

% Expand nonterminal at top of stack
acceptTopDown_(
    Rules,
    [n(N)|Stack0], % parser stack with nonterminal at the top
    Input
  ) :-
       member(rule(_, N, Rhs), Rules),
       append(Rhs, Stack0, Stack1),
       acceptTopDown_(Rules, Stack1, Input).
