% Explosion
explode(
    grammar(_, Rules), % Rules to consult for details
    Root, % Assumed root nonterminal
    ITree, % Imploded (concise) parse tree
    ETree % Exploded (detailed) parse tree
  ) :-
       explode_(Rules, [n(Root)], [ITree], [ETree]).

% Base case; explosion completed
explode_(_, [], [], []).

% Add heading terminal from rule back into exploded form
explode_(
    Rules, 
    [t(T)|Symbols],
    ITrees,
    [leaf(T)|ETrees]
  ) :-
       explode_(Rules, Symbols, ITrees, ETrees).

% Find a rule for the function symbol at hand
explode_(
    Rules,
    [n(N)|Symbols],
    [ITree|ITrees1],
    [fork(Rule, ETrees1)|ETrees2]
  ) :-
       ITree =.. [L|ITrees2],
       Rule = rule(L, N, Rhs),
       member(Rule, Rules), 
       explode_(Rules, Rhs, ITrees2, ETrees1),
       explode_(Rules, Symbols, ITrees1, ETrees2).
