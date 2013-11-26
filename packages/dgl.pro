% Package DGL: Dot-based Graph Language

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').
:- ensure_loaded('packages/cfg.pro').

:- consult('languages/ppl/eval.pro').
:- consult('languages/ppl/to-string.pro').

% Modules for DGL
:- ['languages/dgl/as-to-cs.pro'].

% Test target

dgl_main :- runTests((

   test(
     scannerlessParser(
       (i(term), 'languages/esl/cs.term'),
       (u, signature),
       (i(term), 'languages/esl/ls.term'),
       (u, layout),
       (u, eslMapping),
       (i(text), 'languages/dgl/as.esl'),
       (o(term), 'languages/dgl/as.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/dgl/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/dgl/as.term'),
       (u, graph),
       (i(term), 'languages/dgl/sample-graph.term')
     )
   ),

   test(
     ppDgl(
       (i(term), 'languages/dgl/sample-graph.term'),
       (o(text), 'languages/dgl/sample-graph.dot')
     )
   )

)).
