% Package PP: Pretty printing

% Imports
:- ensure_loaded('../packages/prelude.pro').
:- ensure_loaded('../packages/term.pro').
:- ensure_loaded('../packages/graph.pro').

% Pretty printing engine
:- ['../languages/ppl/eval.pro'].

% Language-specific pretty printers
:- ['../languages/figure/pretty-printer.pro'].
:- ['../languages/graph/pretty-printer.pro'].

% Test target

pp_main :- runTests((

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Tests for the basic evaluator
%

   test(
     pp(
       (u, text('text')),
       (o(text), 'languages/ppl/test-text.txt')
     )
   ),

   test(
     pp(
       (u, vbox(text('a'), vbox(text('b'), text('c')))),
       (o(text), 'languages/ppl/test-vbox.txt')
     )
   ),

   test(
     pp(
       (u, vlist([text('a'), text('b'), text('c')])),
       (o(text), 'languages/ppl/test-vbox.txt')
     )
   ),

   test(
     pp(
       (u, hbox(text('a'), hbox(text(' '), text('b')))),
       (o(text), 'languages/ppl/test-hbox.txt')
     )
   ),

   test(
     pp(
       (u, hlist([text('a'), text(' '), text('b')])),
       (o(text), 'languages/ppl/test-hbox.txt')
     )
   ),

   test(
     pp(
       (u, indent(indent(text('42')))),
       (o(text), 'languages/ppl/test-indent.txt')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Language-specific pretty printers
%

   test(
     ppFigure(
       (i(term), 'languages/figure/sample-line.term'),
       (o(text), 'languages/figure/sample-line.figure')
     )
   ),

   test(
     ppGraph(
       (i(term), 'languages/expr/sample-add.graph'),
       (o(text), 'languages/expr/sample-add.graph')
     )
   )

)).
