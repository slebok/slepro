% Poormen's separator lists
ddlMapping(table, (Name, [Column, Columns]), (Name, [Column|Columns])).

% Lexical mapping for integers
ddlMapping(integer, Digits, Int) :-
  number_codes(Int, Digits).

% Lexical mapping for names
ddlMapping(name, (Char, String), Atom) :-
  name(Atom, [Char|String]).

