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

% Pattern of an EGL-based sample
eglSample(Lang) :-
  TextLang =.. [Lang, text],
  TermLang =.. [Lang, term],
  atom_concat('sample.', Lang, Sample),
  declare(elementOf(Sample, TextLang)),
  declare(elementOf('sample.term', TermLang)),
  declare(mapsTo(parser, [Sample], ['sample.term'])).
