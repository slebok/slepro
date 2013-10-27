% Failure at arity 1
fail(_) :- fail.

% Failure at arity 2
fail(_, _) :- fail.

% Failure at arity 3
fail(_, _, _) :- fail.

% Identity function
id(X,X).

% Add an argument; do not apply
addArg(P1, X, P2) :-
  P1 =.. [F|T1],
  append(T1, [X], T2),
  P2 =.. [F|T2].

% Constant function
const(X,_,X).

% const/2 applied to id/2
constid(_, X, X).

% Skip one argument with a unary predicate
skip(P, _, X) :- apply(P, [X]).

% Skip one argument with a binary predicate
skip(P, _, X, Y) :- apply(P, [X, Y]).

% Try an argument predicate; fall back to ID in case of failure
try(P, X, Y) :-
  apply(P, [X, Y]) ->
      true
    ; id(X, Y).

% Reify success/failure of a goal as a Boolean
toBoolean(G, B) :-
  G -> B = true; B = false.

% All list elements must meet a certain predicate.
map(_, []).
map(G, [H|T]) :- apply(G, [H]), map(G, T).

% The optional element must meet a certain predicate.
option(_, []).
option(P, [X]) :- apply(P, [X]).

% Map a function-like predicate over a list
map(_, [], []).
map(P, [H1|T1], [H2|T2]) :- apply(P, [H1, H2]), map(P, T1, T2).

% Another cardinality for map
map(_, [], [], []).
map(P, [H1|T1], [H2|T2], [H3|T3]) :- apply(P, [H1, H2, H3]), map(P, T1, T2, T3).

% Apply or map for unary predicate
applyOrMap(P, X) :-
  list(X) -> map(P, X); apply(P, [X]).

% Apply or map for binary predicate
applyOrMap(P, X, Y) :-
  list(X) -> map(P, X, Y); apply(P, [X, Y]). 

% Flip two arguments of a predicate
flip(P, A1, A2) :- apply(P, [A2, A1]).

% EBNF-like sequential composition for accumulating predicates
seq(_, [], X, X).
seq(P, [H|T], X, Z) :-
  apply(P, [H, X, Y]),
  seq(P, T, Y, Z).

% EBNF-like "?" for accumulating predicate
option(P, X, Y) :- apply(P, [X, Y]).
option(_, X, X).

% EBNF-like "+" for accumulating predicate
plus(P, X, Z) :- apply(P, [X, Y]), star(P, Y, Z).

% EBNF-like "*" for accumulating predicate
star(P, X, Y) :- plus(P, X, Y).
star(_, X, X).

% Extension of seq/4 to add list construction
seq(_, [], [], X, X).
seq(P, [H1|T1], [H2|T2], X, Z) :-
  apply(P, [H1, H2, X, Y]),
  seq(P, T1, T2, Y, Z).

% Extension of option/3 to add list construction
option(P, [H], X, Y) :- apply(P, [H, X, Y]).
option(_, [], X, X).

% Extension of plus/3 to add list construction
plus(P, [H|T], X, Z) :- apply(P, [H, X, Y]), star(P, T, Y, Z).

% Extension of star/3 to add list construction
star(P, L, X, Y) :- plus(P, L, X, Y).
star(_, [], X, X).

% Peek at accumulator 
peek(P, X, X) :- apply(P, [X, _]).

% Negation for accumulators
not(P, X, X) :- \+ peek(P, X, X).

% A map that also filters
mapfilter(_, [], []).
mapfilter(P, [H1|T1], L) :-
  mapfilter(P, T1, T2),
  ( 
    apply(P, [H1, H2]) ->
        L = [H2|T2]
      ; L = T2
  ).

% Left-associative list fold
foldl(_, U, [], U).
foldl(F, U, [H|T], Z) :- 
  apply(F, [U, H, Y]), 
  foldl(F, Y, T, Z).

% Right-associative list fold
foldr(_, X, [], X).
foldr(F, X, [H|T], Z) :- 
  foldr(F, X, T, Y), 
  apply(F, [H, Y, Z]).
