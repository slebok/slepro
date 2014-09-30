% Pattern of a BGL- and BSL-based concrete syntax definition
bglSyntax(Lang) :-
  TextLang =.. [Lang, text],
  TokenLang =.. [Lang, tokens(term)],
  PTreeLang =.. [Lang, ptree(term)],
  TermLang =.. [Lang, term],
  atom_concat(Lang, 'Scanner', Scanner),
  declare(language(TextLang)),
  declare(language(TokenLang)),
  declare(language(PTreeLang)),
  declare(language(TermLang)),
  declare(membership(TextLang, bglTopDownAcceptor(Scanner), ['cs.term'])),
  declare(membership(TokenLang, bglTopDownAcceptor, ['cs.term'])),
  declare(membership(PTreeLang, succeed, [])), % See implosion/explosion
  declare(membership(TermLang, bslChecker, ['as.term'])),
  declare(function(scanner, [TextLang], [TokenLang], Scanner, [])),
  declare(function(parser, [TokenLang], [TermLang], bglTopDownParser, ['cs.term'])),
  declare(function(parser, [TextLang], [TermLang], bglTopDownParser(Scanner), ['cs.term'])),
  declare(function(imploder, [PTreeLang], [TermLang], bglImploder, [])),
  declare(function(exploder, [TermLang], [PTreeLang], bglExploder, ['cs.term'])),
  declare(elementOf('cs.bgl', bgl(text))),
  declare(elementOf('cs.term', bgl(term))),
  declare(elementOf('as.term', bsl(term))),
  declare(mapsTo(parser, ['cs.bgl'], ['cs.term'])),
  declare(mapsTo(projection, ['cs.term'], ['as.term'])).

% Pattern of a BGL-based sample
bglSample(Lang) :-
  TextLang =.. [Lang, text],
  TokenLang =.. [Lang, tokens(term)],
  PTreeLang =.. [Lang, ptree(term)],
  TermLang =.. [Lang, term],
  atom_concat('sample.', Lang, Sample),
  declare(elementOf(Sample, TextLang)),
  declare(elementOf('sample.tokens', TokenLang)),
  declare(elementOf('sample.ptree', PTreeLang)),
  declare(elementOf('sample.term', TermLang)),
  declare(mapsTo(scanner, [Sample], ['sample.tokens'])),
  declare(mapsTo(parser, ['sample.tokens'], ['sample.term'])),
  declare(mapsTo(parser, [Sample], ['sample.term'])),
  declare(mapsTo(imploder, ['sample.ptree'], ['sample.term'])),
  declare(mapsTo(exploder, ['sample.term'], ['sample.ptree'])).
