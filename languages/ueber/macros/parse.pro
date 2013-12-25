% Reusable pattern of parsing a sample
parse(TextFile) :-
  name(TextFile, Str),
  append(StemStr, [0'.|LangStr], Str),
  name(Lang, LangStr),
  name(Stem, StemStr),
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  atom_concat([Stem, '.term'], TermFile),
  declare(elementOf(TextFile, TextLang)),
  declare(elementOf(TermFile, TermLang)),
  declare(mapsTo(parser, [TextFile], [TermFile])).
