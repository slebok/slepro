% Well-typed terms
wellTypedTerm(Sig, Sort, Term) :-
  require(
    appliedSignatureExpected,
    appliedSignature(Sig)
  ),
  require(
    appliedTermExpected,
    appliedTerm(Term)
  ),
  Sig = signature(Decls),
  wellTypedTerm_(Decls, sort(Sort), Term).

% Apply symbol
wellTypedTerm_(Decls, sort(Result), Term) :-
  Term =.. [Symbol|Terms],
  member(symbol(Symbol, Arguments, Result), Decls),
  map(wellTypedTerm_(Decls), Arguments, Terms).

% Apply alias
wellTypedTerm_(Decls, sort(Sort), Term) :-
  member(alias(Sort, Type), Decls),
  wellTypedTerm_(Decls, Type, Term).

% Test for atoms
wellTypedTerm_(_, atom, Term) :-
  atom(Term).

% Test for integers
wellTypedTerm_(_, integer, Term) :-
  integer(Term).

% Test for Booleans
wellTypedTerm_(_, boolean, Term) :-
  boolean(Term).

% Test for (any) applied term
wellTypedTerm_(_, term, Term) :-
  appliedTerm(Term).

% Test for lists
wellTypedTerm_(Decls, list(Type), Terms) :-
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
