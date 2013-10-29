% Top-level predicate
pp(Box, S) :-
  ppEval(Box, L),
  with_output_to(codes(S), map(ppLine, L)).

% Helper for "printing" lines (strings)
ppLine(S) :-
  format('~s~n', [S]).
