% Convert a grammar to a signature
bglToBsl(
    grammar(Nonterminals, Rules),
    signature(Sorts, STypes)
  ) :-
       Nonterminals = Sorts,
       map(rule2sType, Rules, STypes).

% Convert a rule to a symbol type
rule2sType(
    rule(Label, Lhs, Rhs),
    symbol(Symbol, Arguments, Result)
  ) :-
       Label = Symbol,
       Lhs = Result,
       rhs2arguments(Rhs, Arguments).

% Empty (remaining) RHS maps to null arguments
rhs2arguments([], []).

% Terminals are not mapped to the signature
rhs2arguments([t(_)|Symbols], Sorts) :-
  rhs2arguments(Symbols, Sorts).

% Nonterminals are mapped to sorts
rhs2arguments([n(Nonterminal)|Symbols], [Sort|Sorts]) :-
  Nonterminal = Sort,
  rhs2arguments(Symbols, Sorts).
