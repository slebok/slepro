% Membership test
bslLanguage(File, Term) :-
  readTermFile(File, Sig),
  Sig = signature([Sort|_], _),
  manySortedTerm(Sig, Term, Sort).
