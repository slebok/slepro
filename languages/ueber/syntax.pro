% Reusable pattern of concrete and abstract syntax definition
syntax(Lang) :-
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  ConSyn = ['cs.term', 'ls.term'],
  AbsSyn = ['as.term'],
  atom_concat(Lang, 'Mapping', Mapping),
  language(TextLang, eglLanguage(Mapping), ConSyn),
  language(TermLang, eslLanguage, AbsSyn),
  parser(TextLang, TermLang, eglParser(Mapping), ConSyn),
  elementOf('cs.egl', egl(text)),
  elementOf('cs.term', egl(term)),
  elementOf('ls.egl', egl(text)),
  elementOf('ls.term', egl(term)),
  elementOf('as.esl', esl(text)),
  elementOf('as.term', esl(term)),
  parsesTo('cs.egl', 'cs.term'),
  parsesTo('ls.egl', 'ls.term'),
  parsesTo('as.esl', 'as.term').
