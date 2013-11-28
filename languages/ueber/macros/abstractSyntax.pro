abstractSyntax(Lang) :-
  TermLang =.. [ppl, term],
  elementOf('as.esl', esl(text)),
  elementOf('as.term', esl(term)),
  mapsTo(parser, ['as.esl'], ['as.term']),
  language(TermLang),
  membership(TermLang, eslLanguage, ['as.term']).
