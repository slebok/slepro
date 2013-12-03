% Run the megamodel
run :-
  format('~nMegamodel execution:~n', []),
  findall(D, declaration(D), L),
  initTesting,
  map(evaluate, L).

% Evaluate a udecl
evaluate(D) :-
  format(' * ~q~n',[D]),
  once(evaluate_(D)).

evaluate_(language(_)).

evaluate_(membership(Lang, _, _)) :-
  requireLanguage(Lang).

evaluate_(equivalence(Lang, _, _)) :-
  requireLanguage(Lang).
    
evaluate_(elementOf(File, Lang)) :-
  require(
    declarationOfMembership(Lang),
    declaration(membership(Lang, Pred, Args1))
  ),
  readFile(File, Content),
  append(Args1, [Content], Args2),
  require(
    elementOf(File, Lang),
    apply(Pred, Args2)
  ).

evaluate_(function(_, LangsIn, LangsOut, _, _)) :-
  map(requireLanguage, LangsIn),
  map(requireLanguage, LangsOut).

% Apply a declared function
evaluate_(mapsTo(Func, FilesIn, FilesOut)) :-
  declaration(function(Func, _, _, _, _)),
  require(
    resolution(Func, FilesIn, FilesOut),
    (
      declaration(function(Func, LangsIn, LangsOut, Pred1, ArgsAbs)),
      map(getLanguage, FilesIn, LangsIn),
      map(getLanguage, FilesOut, LangsOut)
    )
  ),
  Pred1 =.. [Sym|PredArgs],
  append(PredArgs, ArgsAbs, AllArgs),
  Pred2 =.. [Sym|AllArgs],
  mapTo(Pred2, FilesIn, FilesOut).

% Apply a predicate as a function
evaluate_(mapsTo(Func, FilesIn, FilesOut)) :-
  \+ declaration(function(Func, _, _, _, _)),
  mapTo(Func, FilesIn, FilesOut).

% Predicate application to files
mapTo(Pred, FilesIn, FilesOut) :-
  map(readFile, FilesIn, ContentsIn),
  map(readFile, FilesOut, Expected),
  map(getLanguage, FilesOut, LangsOut),
  map(succeed, Expected, Actual),
  append(ContentsIn, Actual, Args),
  zip(FilesOut, LangsOut, Expected, Actual, ZArgs),
  require(
    mappable(Pred, FilesIn),
    apply(Pred, Args)
  ),
  map(equiv, ZArgs).


/*
evaluate_(parsesTo(FileIn, FileOut)) :-
  require(
    languageOf(FileIn),
    declaration(elementOf(FileIn, LangIn))
  ),
  require(
    languageOf(FileOut),
    declaration(elementOf(FileOut, LangOut))
  ),
  require(
    parserFromTo(LangIn, LangOut),
    declaration(parser(LangIn, LangOut, Pred, Args1))
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
*/

readFile(File, Content) :-
  require(
    languageOf(File),
    getLanguage(File, Lang)
  ),
  ( textLanguage(Lang), readTextFile(File, Content)
  ; termLanguage(Lang), readTermFile(File, Content) ).

requireLanguage(Lang) :-
  require(
    declarationOfLanguage(Lang),
    declaration(language(Lang))
  ).

getLanguage(File, Lang) :-
  declaration(elementOf(File, Lang)).

equiv((File, Lang, Expected, Actual)) :-
  ( declaration(equivalence(Lang, Pred, Args1)) ->
        true
      ; Pred = (==), Args1 = [] 
  ),
  append(Args1, [Expected, Actual], Args2),
  require(
    equiv(File, Lang, Expected, Actual),
    apply(Pred, Args2) 
  ).

textLanguage(text).
textLanguage(X) :- X =.. [_,Y], textLanguage(Y).

termLanguage(term).
termLanguage(X) :- X =.. [_,Y], termLanguage(Y).
