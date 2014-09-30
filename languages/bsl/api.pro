% BSL-based conformance checker
bslChecker(File, Term) :-
  readTermFile(File, Sig),
  Sig = signature([Sort|_], _),
  manySortedTerm(Sig, Term, Sort).
