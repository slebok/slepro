% Explosion
explode(
    Rules, % Rules to consult for details
    ITree, % Imploded (concise) parse tree
    ETree % Exploded (detailed) parse tree
  ) :-
       Rules = [(_, Root, _)|_],
       explode(Rules, [n(Root)], [ITree], [ETree]).

% Base case; explosion completed
explode(_, [], [], []).

% Add heading terminal from rule back into exploded form
explode(
    Rules, 
    [t(T)|Symbols],
    ITrees,
    [leaf(T)|ETrees]
  ) :-
       explode(Rules, Symbols, ITrees, ETrees).

% Find a rule for the function symbol at hand
explode(
    Rules,
    [n(N)|Symbols],
    [ITree|ITrees1],
    [fork(Rule, ETrees1)|ETrees2]
  ) :-
       ITree =.. [L|ITrees2],
       Rule = (L, N, Rhs),
       member(Rule, Rules), 
       explode(Rules, Rhs, ITrees2, ETrees1),
       explode(Rules, Symbols, ITrees1, ETrees2).
