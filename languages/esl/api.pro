% Membership test
eslLanguage(File, Term) :-
  readTermFile(File, Decls),
  [Decl|_] = Decls,
  ( Decl = symbol(_, _, Sort)
  ; Decl = type(Sort, _) ),
  wellTypedTerm(Decls, Sort, Term).
