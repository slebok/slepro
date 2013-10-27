% Applied terms also covering lists and pairs
appliedTerm(Term) :-
  Term =.. [Symbol|Terms],
  atom(Symbol),
  map(appliedTerm, Terms).

% Integers as applied terms
appliedTerm(Term) :-
  integer(Term).
