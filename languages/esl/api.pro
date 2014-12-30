% Membership test
eslChecker(File, Term) :-
  eslLanguage(File, Term).

eslLanguage(File, Term) :-
  readTermFile(File, Decls),
  [Decl|_] = Decls,
  ( Decl = symbol(_, _, Sort)
  ; Decl = type(Sort, _) ),
  wellTypedTerm(Decls, sort(Sort), Term).
