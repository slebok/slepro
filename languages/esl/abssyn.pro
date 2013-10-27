% An applied signature
appliedSignature(Sig) :-

  require(
    appliedTermExpected,
    appliedTerm(Sig)),

  Sig = signature(Decls),

  % No confusion of symbols and aliases
  \+ (
    member(symbol(_, _, Sort), Decls),
    member(alias(Sort, _), Decls)
  ),

  % No double declarations of symbols
  \+ (
    member(symbol(Symbol, Arguments1, Result1), Decls),
    member(symbol(Symbol, Arguments2, Result2), Decls),
    \+ (
      Arguments1 == Arguments2,
      Result1 == Result2
    )
  ),

  % No double declarations of aliases
  \+ (
    member(alias(Sort, Type1), Decls),
    member(alias(Sort, Type2), Decls),
    \+ Type1 == Type2
  ),

  % Per-declaration well-formedness
  map(appliedDecl, Decls).

% A declaration of a symbol
appliedDecl(symbol(_, Arguments, Result)) :-
  map(appliedType, Arguments),
  appliedSort(Result).

% A declaration of an alias
appliedDecl(alias(Sort, Type)) :-
  appliedSort(Sort),
  appliedType(Type).

% Some sorts are reserved as "primitive types"
appliedSort(Sort) :-
  \+ member(Sort, [
       atom, 
       integer, 
       boolean, 
       term
     ]).

% An applied term type 
appliedType(atom).
appliedType(integer).
appliedType(boolean).
appliedType(term).
appliedType(sort(Sort)) :- 
  appliedSort(Sort).
appliedType(list(Type)) :- 
  appliedType(Type).
appliedType(tuple(Types)) :-
  map(appliedType, Types).
appliedType(option(Type)) :- 
  appliedType(Type).
