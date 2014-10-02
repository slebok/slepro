% Pattern of a MML-based metamodel
mmlSyntax(Lang) :-
  GraphLang =.. [Lang, graph(term)],
  declare(language(GraphLang)),
  declare(elementOf('mm.mml', mml(text))),
  declare(elementOf('mm.term', mml(term))),
  declare(elementOf('mm.graph', mml(graph(term)))),
  declare(mapsTo(parser, ['mm.mml'], ['mm.term'])),
  declare(mapsTo(resolver, ['mm.term'], ['mm.graph'])),
  declare(membership(GraphLang, mmlChecker, ['mm.graph'])),
  declare(equivalence(GraphLang, graphEq, [])).

% Pattern of a MML-based sample
mmlSample(Lang, Sample) :-
  GraphLang =.. [Lang, graph(term)],
  atom_concat(Sample, '.graph', Graph),
  declare(elementOf(Graph, GraphLang)).

% Default for the sample's name
mmlSample(Lang) :-
  mmlSample(Lang, sample).
