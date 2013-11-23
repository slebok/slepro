% Membership test
bslTermElementOf(Term, File) :-
  readTermFile(File, Sig),
  Sig = signature([Sort|_], _),
  manySortedTerm(Sig, Term, Sort).
