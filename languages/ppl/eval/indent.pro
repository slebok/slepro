% Apply indentation
ppEval(indent(B), L) :-
  ppEval(hbox(text(' '), B), L).
