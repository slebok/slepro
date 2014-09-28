% Run the megamodel
run :-
  format('~nMegamodel execution:~n', []),
  findall(D, declaration(D), L),
  initTesting,
  map(evaluate, L),
  listing(problem/1),
  ( problem(_) -> abort; true ).

:- dynamic problem/1.

% Report a problem
report(X) :-
  problem(X) -> 
      true
    ; assertz(problem(X)).

% Evaluate a udecl
evaluate(D) :-
  format(' * ~q: ',[D]),
  once(
    ( evaluate_(D) ->
        format('OK~n',[])
      ; 
        format('FAIL~n',[]),
        report(failedDeclaration(D))
    )
  ).

evaluate_(language(_)).

evaluate_(membership(Lang, _, _)) :-
  requireLanguage(Lang).

evaluate_(equivalence(Lang, _, _)) :-
  requireLanguage(Lang).

evaluate_(function(_, LangsIn, LangsOut, _, _)) :-
  map(requireLanguage, LangsIn),
  map(requireLanguage, LangsOut).
    
evaluate_(elementOf(File, Lang)) :-
  elementOf(File, Lang).

% Apply a declared function
evaluate_(mapsTo(Func, FilesIn, FilesOut)) :-
  declaration(function(Func, _, _, _, _)),
  ( (
      declaration(function(Func, LangsIn, LangsOut, Pred1, ArgsAbs)),
      map(getLanguage, FilesIn, LangsIn),
      map(getLanguage, FilesOut, LangsOut)
    ) ->
        Pred1 =.. [Sym|PredArgs],
        append(PredArgs, ArgsAbs, AllArgs),
        Pred2 =.. [Sym|AllArgs],
        mapsTo(Pred2, FilesIn, FilesOut)
      ;
        report(missingOverload(Func, FilesIn, FilesOut))
  ).

% Apply a predicate as a function
evaluate_(mapsTo(Func, FilesIn, FilesOut)) :-
  \+ declaration(function(Func, _, _, _, _)),
  mapsTo(Func, FilesIn, FilesOut).

evaluate_(not(X)) :-
  not(evaluate_(X)).

% Predicate for element-of test 
elementOf(File, Lang) :-
  findall(
    (Pred, Args1), 
    declaration(membership(Lang, Pred, Args1)),
    Preds), 
  ( Preds == [] ->
        report(missingLanguage(Lang))
      ; 
        readFile(File, [Content]),
        map(membership(Content), Preds)
  ).

% There may be multiple membership predicates
membership(Content, (Pred, Args1)) :-
  append(Args1, [Content], Args2),
  once(apply(Pred, Args2)).

% Predicate application to files
mapsTo(Pred, FilesIn, FilesOut) :-
  map(readFileStrictly, FilesIn, ContentsIn),
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

% Fail for missing file
readFileStrictly(File, Content) :-
  readFile(File, [Content]).

% Read file, if present
readFile(File, MaybeContent) :-
  exists_file(File) ->
      ( (
          getLanguage(File, Lang),
          baseLanguage(Lang, Base)
        ) ->
            ( Base == text, readTextFile(File, Content)
            ; Base == term, readTermFile(File, Content)
            ),
            MaybeContent = [Content]
          ;
            report(obscureFile(File)),
            MaybeContent = [Content]
      )
    ;
      report(missingFile(File)),
      MaybeContent = [].    

% Write file, if present
writeFile(File, Content) :-
  require(
    languageOf(File),
    getLanguage(File, Lang)
  ),
  baseLanguage(Lang, Base),
  ( Base == text, writeTextFile(File, Content)
  ; Base == term, writeTermFile(File, Content)
  ).

requireLanguage(Lang) :-
  require(
    declarationOfLanguage(Lang),
    declaration(language(Lang))
  ).

% A file's language is derived from not/elementOf declarations
getLanguage(File, Lang) :-
   declaration(elementOf(File, Lang))
 ; declaration(not(elementOf(File, Lang))).

% Establish equivalence between 'expected' and 'actual'
equiv((File, Lang, [Expected], Actual)) :-
  ( declaration(equivalence(Lang, Pred, Args1)) ->
        true
      ; Pred = (==), Args1 = [] 
  ),
  append(Args1, [Expected, Actual], Args2),
  ( apply(Pred, Args2) ->
        true
      ; 
        current_prolog_flag(argv, Argv),
        ( member(override, Argv) ->
              writeFile(File, Actual)
            ; 
              error(equiv(File, Lang, Expected, Actual))
        )
  ).

% Force creation of missing baseline
equiv((File, _, [], Content)) :-
  current_prolog_flag(argv, Argv),
  member(create, Argv),
  writeFile(File, Content).

% Determine 'text' or 'term' as the base language of any language
baseLanguage(text, text).
baseLanguage(term, term).
baseLanguage(X, Z) :-
  X =.. [_,Y],
  baseLanguage(Y, Z).
