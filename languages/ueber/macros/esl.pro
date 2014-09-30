% Pattern of an ESL-based abstract syntax definition
eslSyntax(Lang) :-
  TermLang =.. [Lang, term],
  declare(language(TermLang)),
  declare(elementOf('as.esl', esl(text))),
  declare(elementOf('as.term', esl(term))),
  declare(mapsTo(parser, ['as.esl'], ['as.term'])),
  declare(membership(TermLang, eslLanguage, ['as.term'])).
