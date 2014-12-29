% Convert a grammar to a signature
bglToBsl(Rules, Profiles) :-
   map(rule2profile, Rules, Profiles).

% Convert a rule to a profile
rule2profile(
    (Label, Lhs, Rhs),
    (Symbol, Arguments, Result)
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
