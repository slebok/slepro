mmlMapping(name, String, Atom) :-
  name(Atom, String).

mmlMapping(abstract, abstract, true).
mmlMapping(abstract, concrete, false).
