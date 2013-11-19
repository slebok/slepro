eglMapping(qstring, (_, String, _), Atom) :-
  atom_codes(Atom, String).

eglMapping(name, String, Atom) :-
  name(Atom, String).
