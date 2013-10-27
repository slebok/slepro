% Many-sorted terms for a given signature
manySortedTerm(Sig, Term, Sort) :-
  signature(Sig),
  prefixTerm(Term),
  Sig = signature(Sorts, Profiles),
  member(Sort, Sorts),
  manySortedTerm_(Profiles, Term, Sort).

% Recursive test for term symbols to comply with a type
manySortedTerm_(Profiles, Term, Result) :-
  Term =.. [Symbol|Terms],
  member(symbol(Symbol, Arguments, Result), Profiles),
  map(manySortedTerm_(Profiles), Terms, Arguments).
