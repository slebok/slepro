eglMapping(qstring, (_, String, _), Atom) :-
  name(Atom, String).

eglMapping(name, String, Atom) :-
  name(Atom, String).
