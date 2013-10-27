% Implosion
implode(
    ETree, % Exploded (detailed) parse tree
    ITree % Imploded (concise) parse tree
  ) :-
       implode_([ETree], [ITree]).

% Base case; implosion completed
implode_([], []).

% Omit terminal from exploded tree in imploded one
implode_(
    [leaf(_)|ETrees], % terminal tree in front
    ITrees % recursively imploded trees
  ) :-
       implode_(ETrees, ITrees).

% Implode subtree recursively
implode_(
    [fork(rule(L, _, _), ETrees1)|ETrees2], % nonterminal tree in front
    [ITree|ITrees2] % binarily recursively imploded trees
  ) :-
       implode_(ETrees1, ITrees1),
       ITree =.. [L|ITrees1], % leverage label as function symbol
       implode_(ETrees2, ITrees2).
