% Applied terms also covering lists and pairs
appliedTerm(Term) :-
  Term =.. [Symbol|Terms],
  atom(Symbol),
  map(appliedTerm, Terms).

% Numbers as applied terms
appliedTerm(Term) :-
  number(Term).
