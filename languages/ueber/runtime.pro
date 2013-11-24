:- nb_setval(ueber_level, 1).
:- nb_setval(ueber_dir, '').

% Indentation
ueber_indent :-
  nb_getval(ueber_level, L),
  ueber_indent(L).
ueber_indent(0).
ueber_indent(L1) :- L1 > 0, write(' '), L2 is L1 - 1, ueber_indent(L2).

init :-
  format('Megamodel preprocessing:~n', []).

% Load a local Prolog file
load(File) :-
  ueber_indent,
  format('* load(~q)~n',[File]),
  atom(File),
  atom_codes(File, String),
  \+ member(0'\\, String),
  \+ member(0'/, String),
  consult(File).

% Enter a new subdirectory and load the .ueber file
enter(RelDir) :-
  nb_getval(ueber_dir, Dir),
  (  
    Dir == '' ->
        AbsDir = RelDir
      ; atomic_list_concat([Dir, '/', RelDir], AbsDir)
  ),
  ueber_indent,
  format('> enter(~q)~n',[RelDir]),
  atom_concat(RelDir, '/.ueber', File),
  nb_getval(ueber_level, L1),
  L2 is L1 + 1,
  nb_setval(ueber_level, L2),
  nb_setval(ueber_dir, AbsDir),
  consult(File),
  nb_setval(ueber_level, L1),
  nb_setval(ueber_dir, Dir).

% Pre-process elementOf/3 relationship
elementOf(Rel, Lang) :-
  ueber_absolute(Rel, Abs),
  ueber_indent,
  format('* elementOf(~q, ~q)~n',[Rel, Lang]),
  assertz(relationship(elementOf(Abs, Lang))).

% Pre-process mapsTo/3 relationship
mapsTo(F, ArgRel, ResRel) :-
  ueber_absolute(ArgRel, ArgAbs),
  ueber_absolute(ResRel, ResAbs),
  ueber_indent,
  format('* mapsTo(~q, ~q, ~q)~n',[F, ArgRel, ResRel]),
  assertz(relationship(mapsTo(F, ArgAbs, ResAbs))).

% Pre-process interpretation
interpret(Sym, Dis, Inter, ArgsRel) :-
  map(ueber_absolute, ArgsRel, ArgsAbs),
  assertz(interpretation(Sym, Dis, Inter, ArgsAbs)).
  
% Make a pseudo-absolute filename
ueber_absolute(Rel, Abs) :-
  nb_getval(ueber_dir, Dir),
  (  
    Dir == '' ->
        Abs = Rel
      ; atomic_list_concat([Dir, '/', Rel], Abs)
  ).

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
    elementOfInterpretation,
    interpretation(elementOf, [Lang], P, Args1)
  ),
  readFile(File, Content),
  append(Args1, [Content], Args2),
  require(
    elementOfSuccess,
    apply(P, Args2)
  ).

evaluate_(mapsTo(F, FileIn, FileOut)) :-
  readFile(FileIn, ContentIn),
  readFile(FileOut, ContentOut),
  require(
    mapsToExpected,
    apply(F, [ContentIn, ContentOut])
  ).

readFile(File, Content) :-
  require(
    associatedLanguage,
    relationship(elementOf(File, Lang))
  ),
  ( textLanguage(Lang), readTextFile(File, Content)
  ; termLanguage(Lang), readTermFile(File, Content) ).

textLanguage(text).
textLanguage(X) :- X =.. [_,Y], textLanguage(Y).

termLanguage(term).
termLanguage(X) :- X =.. [_,Y], termLanguage(Y).
