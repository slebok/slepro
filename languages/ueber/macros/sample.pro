% Reusable pattern of parsing a sample
sample(Lang) :-
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  atom_concat('sample.', Lang, TextSample),
  elementOf(TextSample, TextLang),
  elementOf('sample.term', TermLang),
  mapsTo(parser, [TextSample], ['sample.term']).
