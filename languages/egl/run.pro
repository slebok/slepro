scannerfullEgl(Text, Term) :-
  require(
    scannerFailed(egl),
    tokens(eglToken, Text, Tokens)),
  File = 'languages/egl/cs.term',
  require(
    fileNotReadable(File),
    readTermFile(File, Egl)),
  require(
    parserFailed(egl),
    scannerfullParser(Egl, grammar, fail, Tokens, Term)).

scannerlessEgl(Text, Term) :-
  File1 = 'languages/egl/cs.term',
  require(
    fileNotReadable(File1),
    readTermFile(File1, Consyn)),
  File2 = 'languages/egl/ls.term',
  require(
    fileNotReadable(File2),
    readTermFile(File2, Lexsyn)),
  require(
    parserFailed(egl),
    scannerlessParser(Consyn, grammar, Lexsyn, layout, eglMapping, Text, Term)).
