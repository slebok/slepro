% Membership test
bslChecker(File, Term) :-
  bslLanguage(File, Term).

bslLanguage(File, Term) :-
  readTermFile(File, Sig),
  Sig = [symbol(_, _, Sort)|_],
  manySortedTerm(Sig, Term, Sort).

% Parser of BSL signatures relying on ESL
parserOfBsl(Text, Term2) :-
  FileCfSyn = 'languages/esl/cs.term',
  require(
    fileNotReadable(FileCfSyn),
    readTermFile(FileCfSyn, CfSyn)),
  FileLexSyn = 'languages/esl/ls.term',
  require(
    fileNotReadable(FileLexSyn),
    readTermFile(FileLexSyn, LexSyn)),
  require(
    parserFailed(esl),
    scannerless(layout, eslMapping, CfSyn, LexSyn, Text, Term1)),
  require(
    bglSubset,
    eslToBsl(Term1, Term2)
  ).

% Membership test for BSL by attempted parsing
elementOfBsl(Text) :-
  parserOfBsl(Text, _).
