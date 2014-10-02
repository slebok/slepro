% Reusable pattern of parsing a file
parse(TextFile) :-
  name(TextFile, Str),
  append(StemStr, [0'.|LangStr], Str),
  \+ member(0'., LangStr),
  name(Lang, LangStr),
  name(Stem, StemStr),
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  atom_concat([Stem, '.term'], TermFile),
  declare(elementOf(TextFile, TextLang)),
  declare(elementOf(TermFile, TermLang)),
  declare(mapsTo(parser, [TextFile], [TermFile])).

% Variation that takes just the language
parse(Lang) :-
  name(Lang, Str),
  \+ member(0'., Str),
  atom_concat('sample.', Lang, TextFile),
  parse(TextFile).
