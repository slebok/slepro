% Well-typed terms
wellTypedTerm(Decls, Sort, Term) :-
  require(
    appliedSignatureExpected,
    appliedSignature(Decls)
  ),
  require(
    appliedTermExpected,
    appliedTerm(Term)
  ),
  wellTypedTerm_(Decls, sort(Sort), Term).

% Apply symbol
wellTypedTerm_(Decls, sort(Result), Term) :-
  Term =.. [Symbol|Terms],
  member(symbol(Symbol, Arguments, Result), Decls),
  map(wellTypedTerm_(Decls), Arguments, Terms).

% Apply type
wellTypedTerm_(Decls, sort(Sort), Term) :-
  member(type(Sort, Type), Decls),
  wellTypedTerm_(Decls, Type, Term).

% Test for atoms
wellTypedTerm_(_, term, Term) :-
  appliedTerm(Term).

% Test for atoms
wellTypedTerm_(_, atom, Term) :-
  atom(Term).

% Test for integers
wellTypedTerm_(_, integer, Term) :-
  integer(Term).

% Test for floats
wellTypedTerm_(_, float, Term) :-
  float(Term).

% Test for numbers
wellTypedTerm_(_, number, Term) :-
  number(Term).

% Test for Booleans
wellTypedTerm_(_, boolean, Term) :-
  boolean(Term).

% Test for (any) applied term
wellTypedTerm_(_, term, Term) :-
  appliedTerm(Term).

% Test for lists
wellTypedTerm_(Decls, star(Type), Terms) :-
  map(wellTypedTerm_(Decls, Type), Terms).
wellTypedTerm_(Decls, plus(Type), Terms) :-
  Terms \= [],
  map(wellTypedTerm_(Decls, Type), Terms).

% Test for options
wellTypedTerm_(Decls, option(Type), Terms) :-
  length(Terms, Len),
  Len < 2,
  map(wellTypedTerm_(Decls, Type), Terms).

% Base case for tuples
wellTypedTerm_(
    Decls,
    tuple([Type]),
    Term
  ) :-
    wellTypedTerm_(Decls, Type, Term).

% Step case for tuples
wellTypedTerm_(
    Decls,
    tuple([Type|Types]),
    (Term, Terms)
  ) :-
    Types \= [],
    wellTypedTerm_(Decls, Type, Term),
    wellTypedTerm_(Decls, tuple(Types), Terms).

% Test for optional terms
wellTypedTerm_(Decls, option(Type), Terms) :-
  length(Terms, Len),
  member(Len, [0,1]),
  map(wellTypedTerm_(Decls, Type), Terms).
