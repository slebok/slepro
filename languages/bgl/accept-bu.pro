% Accept input bottom-up
acceptBottomUp(Rules, Input) :-
    Rules = [(_, Root, _)|_],
    acceptBottomUp(Rules, Root, [], Input).

% Acceptance completed
acceptBottomUp(_, Root, [n(Root)], []).

% Shift terminal from input to stack
acceptBottomUp(Rules, Root, Stack0, [T|Input0]) :-
    append(Stack0, [t(T)], Stack1),
    acceptBottomUp(Rules, Root, Stack1, Input0).

% Reduce prefix on stack to nonterminal
acceptBottomUp(Rules, Root, Stack0, Input0) :-
    % Remove a prefix from the stack
    append(Stack1, Rhs, Stack0),
    % Find the prefix as the RHS of a rule
    member((_, N, Rhs), Rules),
    % Add LHS nonterminal to the stack
    append(Stack1, [n(N)], Stack2),
    % Proceed recursively
    acceptBottomUp(Rules, Root, Stack2, Input0).
