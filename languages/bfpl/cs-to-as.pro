% Mapping for function types
bfplMapping(type, (T1, Ts1), ([T1|Ts2], T2)) :-
  append(Ts2, [T2], Ts1).

% Eliminate layering in expressions
bfplMapping(expr, subexpr(E), E).

% Eliminate brackets in expressions
bfplMapping(subexpr, brackets(E), E).

% Lexical mapping for int
bfplMapping(int, Digits, Int) :-
  number_codes(Int, Digits).

% Lexical mapping for name
bfplMapping(name, (Char, String), Atom) :-
  name(Atom, [Char|String]).

