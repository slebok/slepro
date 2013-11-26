% Run the megamodel
run :-
  format('~nMegamodel execution:~n', []),
  findall(R, relationship(R), L),
  initTesting,
  map(evaluate, L).

% Evaluate a relationship
evaluate(R) :-
  format(' * ~q~n',[R]),
  evaluate_(R).

evaluate_(elementOf(File, Lang)) :-
  require(
    declarationOfLanguage(Lang),
    interpretation(language(Lang, Pred, Args1))
  ),
  readFile(File, Content),
  append(Args1, [Content], Args2),
  require(
    elementOf(Lang),
    apply(Pred, Args2)
  ).

evaluate_(mapsTo(F, FilesIn, FilesOut)) :-
  map(readFile, FilesIn, ContentsIn),
  map(readFile, FilesOut, Expected),
  map(succeed, Expected, Actual),
  append(ContentsIn, Actual, Args),
  require(
    mappable(F, FilesIn),
    apply(F, Args)
  ),
  require(
    expecedVersusActual(Expected, Actual),
    append(ContentsIn, Expected, Args)  
  ).

evaluate_(parsesTo(FileIn, FileOut)) :-
  require(
    languageOf(FileIn),
    relationship(elementOf(FileIn, LangIn))
  ),
  require(
    languageOf(FileOut),
    relationship(elementOf(FileOut, LangOut))
  ),
  require(
    parserFromTo(LangIn, LangOut),
    interpretation(parser(LangIn, LangOut, Pred, Args1))
  ),
  readFile(FileIn, ContentIn),
  readFile(FileOut, Expected),
  append(Args1, [ContentIn, Actual], Args2),
  require(
    parseable(Pred, FileIn),
    apply(Pred, Args2)
  ),
  require(
    expecedVersusActual(Expected, Actual),
    append(Args1, [ContentIn, Expected], Args2)  
  ).

readFile(File, Content) :-
  require(
    languageOf(File),
    relationship(elementOf(File, Lang))
  ),
  ( textLanguage(Lang), readTextFile(File, Content)
  ; termLanguage(Lang), readTermFile(File, Content) ).

textLanguage(text).
textLanguage(X) :- X =.. [_,Y], textLanguage(Y).

termLanguage(term).
termLanguage(X) :- X =.. [_,Y], termLanguage(Y).