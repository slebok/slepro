bslMapping(name, String, Atom) :-
  name(Atom, String).

bslMapping(args, [X, Y], [X|Y]).
