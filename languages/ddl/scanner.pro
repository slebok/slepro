% Keywords and special characters
tablesToken(Atom) -->
  {
    ( tablesSpecials(Atoms); tablesKeywords(Atoms) ),
    member(Atom, Atoms),
    name(Atom, String)
  },
  String.

% (Non-negative) integer literals
tablesToken(integer(Int)) -->
  plus(char(digit), Digits),
  {  number_codes(Int, Digits) }.

% Names consisting of alphabetic characters
tablesToken(name(Atom)) -->
  char(alpha, Char),
  plus(char(csym), String),
  {
    name(Atom, [Char|String]),
    tablesKeywords(Atoms),
    \+ member(Atom, Atoms)
  }.

tablesSpecials([
  '(',
  ')',
  ',',
  ';'
]).

tablesKeywords([
  'CREATE',
  'TABLE',
  'INTEGER',
  'VARCHAR',
  'NOT',
  'NULL',
  'REFERENCES',
  'PRIMARY',
  'FOREIGN',
  'KEY'
]).
