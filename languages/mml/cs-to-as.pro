classesMapping(name, String, Atom) :-
  name(Atom, String).

classesMapping(abstract, abstract, true).
classesMapping(abstract, concrete, false).
