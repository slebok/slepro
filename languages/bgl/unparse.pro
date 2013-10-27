% Unparse parse tree into terminal string
unparse(Tree, String) :-
  unparse_([Tree], String).

% Base case
unparse_([], []).

% Copy leaf terminal to output string and recurse
unparse_([leaf(T)|Trees], [T|String]) :-
  unparse_(Trees, String).

% Unparse sub-trees of fork tree and remaining trees 
unparse_([fork(_, Trees1)|Trees2], String3) :-
  unparse_(Trees1, String1),
  unparse_(Trees2, String2),
  append(String1, String2, String3).
