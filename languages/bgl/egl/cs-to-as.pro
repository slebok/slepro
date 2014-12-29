bglMapping(qstring, (_, String, _), Atom) :-
  atom_codes(Atom, String).

bglMapping(name, String, Atom) :-
  name(Atom, String).
