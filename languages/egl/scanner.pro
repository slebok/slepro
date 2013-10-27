% Quoted string literals
eglToken(qstring(Atom)) -->
  char(quote),
  star(char(noQuote), String),
  char(quote),
  { name(Atom, String) }.

% Names consisting of alphabetic characters
eglToken(name(Atom)) -->
  plus(char(alpha), String),
  { name(Atom, String) }.

% Keywords and special characters
eglToken(Atom) -->
  {
    member(
      String,
      ["#", "*", "+", "?", "{", "}", "[", "]", ":", ";"]
    ),
    name(Atom, String) 
  },
  String.
