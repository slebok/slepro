% Membership test
eslTermElementOf(Term, File) :-
  readTermFile(File, Decls),
  [Decl|_] = Decls,
  ( Decl = symbol(_, _, Sort)
  ; Decl = type(Sort, _) ),
  wellTypedTerm(Decls, Sort, Term).
