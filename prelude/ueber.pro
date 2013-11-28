:- ['languages/ueber/macros/sample.pro'].
:- ['languages/ueber/macros/abstractSyntax.pro'].
:- ['languages/ueber/macros/syntax.pro'].
:- nb_setval(ueber_level, 1).
:- nb_setval(ueber_dir, '.').

init :-
  format('Megamodel preprocessing:~n', []).

% Check directory to be ueber-preprocessable
preprocess(Dir) :-
  atom_concat(Dir, '/.ueber', File),
  ( exists_file(File) ->
        preprocess(Dir, File)
      ;
        true
  ).

% Preprocess directory and .ueber file
preprocess(Dir, File) :-
  readTermFile(File, Term),
  nb_getval(ueber_level, OldLevel),
  Level is OldLevel + 1,
  nb_setval(ueber_level, Level),
  nb_getval(ueber_dir, OldDir),
  nb_setval(ueber_dir, Dir),
  ueber_indent,
  format('> enter(~q)~n',[Dir]),
  atom_concat(Dir, '/*.pro', ProWildcard),
  atom_concat(Dir, '/*.dcg', DcgWildcard),
  expand_file_name(ProWildcard, ProFiles),
  map(load, ProFiles),
  expand_file_name(DcgWildcard, DcgFiles),
  map(load, DcgFiles),
%  elementOf('.ueber', ueber(term)),
  maplist(call, Term),
  atom_concat(Dir, '/*', Wildcard),
  expand_file_name(Wildcard, Files),
  filter(exists_directory, Files, Dirs),
  map(preprocess, Dirs),
  nb_setval(ueber_level, OldLevel),
  nb_setval(ueber_dir, OldDir).

% Load a Prolog file
load(File) :-
  ueber_indent,
  format(' * load(~q)~n',[File]),
  consult(File).

% Pre-process language declaration
language(Lang, Pred, ArgsRel) :-
  ueber_indent,
  format(' * language(~q, ~q, ~q)~n',[Lang, Pred, ArgsRel]),
  map(ueber_absolute, ArgsRel, ArgsAbs),
  assertz(interpretation(language(Lang, Pred, ArgsAbs))).

% Pre-process equivalence declaration
equivalence(Lang, Pred, ArgsRel) :-
  ueber_indent,
  format(' * equivalence(~q, ~q, ~q)~n',[Lang, Pred, ArgsRel]),
  map(ueber_absolute, ArgsRel, ArgsAbs),
  assertz(interpretation(equivalence(Lang, Pred, ArgsAbs))).

% Pre-process parser declaration
parser(LangIn, LangOut, Pred, ArgsRel) :-
  ueber_indent,
  format(' * parser(~q, ~q, ~q, ~q)~n',[LangIn, LangOut, Pred, ArgsRel]),
  map(ueber_absolute, ArgsRel, ArgsAbs),
  assertz(interpretation(parser(LangIn, LangOut, Pred, ArgsAbs))).
  
% Pre-process elementOf/2 relationship
elementOf(Rel, Lang) :-
  ueber_absolute(Rel, Abs),
  ueber_indent,
  format(' * elementOf(~q, ~q)~n',[Rel, Lang]),
  assertz(relationship(elementOf(Abs, Lang))).

% Pre-process parsesTo relationship
parsesTo(ArgRel, ResRel) :-
  ueber_absolute(ArgRel, ArgAbs),
  ueber_absolute(ResRel, ResAbs),
  ueber_indent,
  format(' * parsesTo(~q, ~q)~n',[ArgRel, ResRel]),
  assertz(relationship(parsesTo(ArgAbs, ResAbs))).

% Pre-process mapsTo relationship
mapsTo(F, ArgsRel, RessRel) :-
  map(ueber_absolute, ArgsRel, ArgsAbs),
  map(ueber_absolute, RessRel, RessAbs),
  ueber_indent,
  format(' * mapsTo(~q, ~q, ~q)~n',[F, ArgsRel, RessRel]),
  assertz(relationship(mapsTo(F, ArgsAbs, RessAbs))).

% Pre-process macro applications
macro(X) :-
  call(X).
  
% Make a pseudo-absolute filename
ueber_absolute(Rel, Abs) :-
  nb_getval(ueber_dir, Dir),
  (  
    Dir == '' ->
        Abs = Rel
      ; atomic_list_concat([Dir, '/', Rel], Abs)
  ).

% Indentation
ueber_indent :-
  nb_getval(ueber_level, L),
  ueber_indent(L).
ueber_indent(0).
ueber_indent(L1) :- 
  L1 > 0,
  write(' '),
  L2 is L1 - 1,
  ueber_indent(L2).
