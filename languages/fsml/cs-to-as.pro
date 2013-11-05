% Mapping for states
fsmMapping(state, (I1, N, Ts1), (I2, N, Ts2)) :-
  toBoolean((I1==initial), I2),
  map(fsmToSelf(N), Ts1, Ts2).

% Lexical mapping for name
fsmMapping(name, String, Atom) :-
  name(Atom, String).

% Make target state mandatory
fsmToSelf(_, (I, A, [S]), (I, A, S)).

% Make self the target state
fsmToSelf(N, (I, A, []), (I, A, N)).
