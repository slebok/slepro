% Recursive test for term symbols to comply with a profile
manySortedTerm(Profiles, Term, Result) :-
  Term =.. [Symbol|Terms],
  member(symbol(Symbol, Arguments, Result), Profiles),
  map(manySortedTerm(Profiles), Terms, Arguments).
