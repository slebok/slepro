eslMapping(typeexpr, (T1, C), T2) :-
  eslCardinality(T1, C, T2).

eslMapping(factor, tuple(T, Ts), tuple([T|Ts])).

eslMapping(name, String, Atom) :-
  name(Atom, String).

eslCardinality(T, none, T).
eslCardinality(T1, star(C), T2) :-
  eslCardinality(star(T1), C, T2).
eslCardinality(T1, plus(C), T2) :-
  eslCardinality(plus(T1), C, T2).
eslCardinality(T1, option(C), T2) :-
  eslCardinality(option(T1), C, T2).
