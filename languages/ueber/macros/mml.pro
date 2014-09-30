% Pattern of a MML-based metamodel
mmlSyntax(Lang) :-
  GraphLang =.. [Lang, graph(term)],
  declare(language(GraphLang)),
  declare(elementOf('mm.mml', mml(text))),
  declare(elementOf('mm.term', mml(term))),
  declare(elementOf('mm.graph', mml(graph(term)))),
  declare(mapsTo(parser, ['mm.mml'], ['mm.term'])),
  declare(mapsTo(resolver, ['mm.term'], ['mm.graph'])),
  declare(membership(expr(graph(term)), mmlChecker, ['mm.graph'])).

% Pattern of a MML-based sample
mmlSample(Lang) :-
  GraphLang =.. [Lang, graph(term)],
  declare(elementOf('sample.graph', GraphLang)),
  declare(elementOf('sample.graph', expr(graph(term)))).
