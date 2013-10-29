% Mapping for function types
yafplMapping(type, (T1, Ts1), ([T1|Ts2], T2)) :-
  append(Ts2, [T2], Ts1).

% Eliminate layering in expressions
yafplMapping(expr, subexpr(E), E).

% Eliminate brackets in expressions
yafplMapping(subexpr, brackets(E), E).

% Lexical mapping for int
yafplMapping(int, Digits, Int) :-
  number_codes(Int, Digits).

% Lexical mapping for name
yafplMapping(name, (Char, String), Atom) :-
  name(Atom, [Char|String]).

