% Pattern of a EGL-based concrete syntax definition
eglSyntax(Lang) :-
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  declare(language(TextLang)),
  declare(language(TermLang)),
  Files = ['cs.term', 'ls.term'],
  atom_concat(Lang, 'Mapping', Mapping),
  declare(membership(TextLang, eglAcceptor(Mapping), Files)),
  declare(function(parser, [TextLang], [TermLang], eglParser(Mapping), Files)),
  declare(elementOf('cs.egl', egl(text))),
  declare(elementOf('cs.term', egl(term))),
  declare(elementOf('ls.egl', egl(text))),
  declare(elementOf('ls.term', egl(term))),
  declare(mapsTo(parser, ['cs.egl'], ['cs.term'])),
  declare(mapsTo(parser, ['ls.egl'], ['ls.term'])).
