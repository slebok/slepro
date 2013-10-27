% Construct a singleton set
singleton(X, [X]).

% Equality on sets
setEq(S1, S2) :-
  subset(S1, S2),
  subset(S2, S1).

% Convert a list into a tuple
list2tuple(Empty, [], Empty).
list2tuple(_, X, Y) :-
  X \= [],
  list2tuple_(X, Y).

list2tuple_([X], X).
list2tuple_([X|Y], (X, Z)) :-
  Y \= [],
  list2tuple_(Y, Z).

% Iterate append/3 over a list of lists
concat(Ls, L) :- 
  foldr(append, [], Ls, L).

% Append atoms
atom_concat([X], X).
atom_concat([X,Y|T], R) :- atom_concat(X, Y, XY), atom_concat([XY|T], R).

% Test a term to be a list
list(T) :- is_list(T).

% Test a term to be an option
option([]).
option([_]).

% Test a term to be a Boolean
boolean(true).
boolean(false).

% Test a term to be a tuple
tuple((_, _)).

% Test a list to be a set
set(List1) :-
  is_set(List1).

% Zip two lists to a list of pairs
zip([], [], []).
zip([H1|T1], [H2|T2], [(H1, H2)|T12]) :- zip(T1, T2, T12).

% Unzip a list of pairs to two lists
unzip(L12, L1, L2) :- zip(L1, L2, L12).

% Maximum
max(X,Y,Z) :- Z is max(X,Y).

% Repeat a value a number of times
repeat(_, 0, []).
repeat(X, N, [X|Xs]) :-
  N > 0,
  M is N - 1,
  repeat(X, M, Xs).
