abstractSyntax(Lang) :-
  TermLang =.. [Lang, term],
  declare(elementOf('as.esl', esl(text))),
  declare(elementOf('as.term', esl(term))),
  declare(mapsTo(parser, ['as.esl'], ['as.term'])),
  declare(language(TermLang)),
  declare(membership(TermLang, eslLanguage, ['as.term'])).
