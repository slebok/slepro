% A signature is a pair of sorts and symbol types.
signature(signature(Sorts, STypes)) :-
  sorts(Sorts),
  sTypes(Sorts, STypes).

% The sorts of a signature form a set of atoms.
sorts(Sorts) :-
  set(Sorts),
  map(atom, Sorts).

% The symbol types form a certain set of certain triples.
sTypes(Sorts, STypes) :-
  map(symbolOfSType, STypes, Symbols),
  is_set(Symbols),
  map(resultOfSType, STypes, ResultsList),
  list_to_set(ResultsList, ResultsSet),
  setEq(ResultsSet, Sorts),
  map(sType(Sorts), STypes).

% The symbol of the symbol type
symbolOfSType(symbol(Symbol, _, _), Symbol).

% The result sort of the symbol type
resultOfSType(symbol(_, _, Result), Result).

% A symbol type consists of a symbol, argument sorts, and a result sort.
sType(Sorts, symbol(Symbol, Arguments, Result)) :-
  atom(Symbol),
  map(flip(member, Sorts), Arguments),
  member(Result, Sorts).
