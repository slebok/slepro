% BSL-based conformance checker
bslChecker(Sort, File, Term) :-
  readTermFile(File, Sig),
  manySortedTerm(Sig, Term, Sort).
