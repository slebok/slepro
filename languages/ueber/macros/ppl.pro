% Pattern of a PPL-based sample
pplSample(Lang) :-
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  atomic_list_concat(['sample.', Lang], TextSample),
  declare(elementOf(TextSample, TextLang)),
  declare(elementOf('sample.ppl', ppl(term))),
  declare(elementOf('sample.term', TermLang)),
  atom_concat(Lang, 'Pp', Pp),
  declare(mapsTo(Pp, ['sample.term'], ['sample.ppl'])),
  declare(mapsTo(pp, ['sample.ppl'], [TextSample])).

