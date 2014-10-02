% Pattern of a PPL-based sample
pplSample(Lang, Sample) :-
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  atomic_list_concat([Sample, '.', Lang], TextSample),
  atom_concat(Sample, '.term', TermSample),
  atom_concat(Sample, '.ppl', PplSample),
  declare(elementOf(TextSample, TextLang)),
  declare(elementOf(PplSample, ppl(term))),
  declare(elementOf(TermSample, TermLang)),
  atom_concat(Lang, 'Pp', Pp),
  declare(mapsTo(Pp, [TermSample], [PplSample])),
  declare(mapsTo(pp, [PplSample], [TextSample])).

% Default name for sample
pplSample(Lang) :-
  pplSample(Lang, sample).
  atom_concat(Sample, '.term', TermSample),
  atom_concat(Sample, '.ppl', PplSample),
  declare(elementOf(TextSample, TextLang)),
