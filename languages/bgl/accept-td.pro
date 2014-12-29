% Accept input top-down
acceptTopDown(Rules, Input) :- 
    Rules = [(_, Root, _)|_],
    acceptTopDown(Rules, [n(Root)], Input).

% Acceptance completed
acceptTopDown(_, [], []).

% Consume terminal at top of stack from input
acceptTopDown(Rules, [t(T)|Stack], [T|Input]) :-
    acceptTopDown(Rules, Stack, Input).

% Expand nonterminal at the top of stack
acceptTopDown(Rules, [n(N)|Stack0], Input) :-
    % Select an alternative with LHS N
    member((_, N, Rhs), Rules),
    % Add RHS to the stack
    append(Rhs, Stack0, Stack1),
    % Proceed recursively
    acceptTopDown(Rules, Stack1, Input).
