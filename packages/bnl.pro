% Imports
:- ensure_loaded('../packages/prelude.pro').
:- ensure_loaded('../packages/term.pro').
:- ensure_loaded('../packages/cfg.pro').

% Language-specific pretty printers
:- ['../languages/bnl/cs.dcg'].
:- ['../languages/bnl/conversion1.dcg'].
:- ['../languages/bnl/conversion2.dcg'].
:- ['../languages/bnl/conversion1.pro'].
:- ['../languages/bnl/conversion2.pro'].
:- ['../languages/bnl/solver.pro'].

% Test target

bnl_main :- runTests((

   test(
     number(
       (i(term), 'languages/bnl/sample.tokens'),
       (u, [])
     )
   ),

   test(
     number_(
       (o(term), 'languages/bnl/sample.value'),
       (i(term), 'languages/bnl/sample.tokens'),
       (u, [])
     )
   ),

   test(
     number__(
       (o(term), 'languages/bnl/sample.formula'),
       (i(term), 'languages/bnl/sample.tokens'),
       (u, [])
     )
   ),

   test(
     solve(
       (i(term), 'languages/bnl/sample.formula'),
       (o(term), 'languages/bnl/sample.value')
     )
   ),

   test(
     asConvert_(
       (i(term), 'languages/bnl/sample.term'),
       (o(term), 'languages/bnl/sample.value')
     )
   ),

   test(
     asConvert__(
       (i(term), 'languages/bnl/sample.term'),
       (o(term), 'languages/bnl/sample.formula')
     )
   ),

   test(
     parseBgl(
       (i(text), 'languages/bnl/cs.bgl'),
       (o(term), 'languages/bnl/cs.term')
     )
   ),

   test(
     bglToBsl(
       (i(term), 'languages/bnl/cs.term'),
       (o(term), 'languages/bnl/as.term')
     )
   ),

   test(
     signature(
       (i(term), 'languages/bnl/as.term')
     )
   ),

   test(
     manySortedTerm(
       (i(term), 'languages/bnl/as.term'),
       (i(term), 'languages/bnl/sample.term'),
       (u, number)
     )
   ),

   test(
     parseTopDownAndImplode(
       (i(term), 'languages/bnl/cs.term'),
       (u, number),
       (i(term), 'languages/bnl/sample.tokens'),
       (o(term), 'languages/bnl/sample.term')
     )
   )

)).
