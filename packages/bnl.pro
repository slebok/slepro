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
       (i(term), 'languages/bnl/sample-number.tokens'),
       (u, [])
     )
   ),

   test(
     number_(
       (o(term), 'languages/bnl/sample-value.term'),
       (i(term), 'languages/bnl/sample-number.tokens'),
       (u, [])
     )
   ),

   test(
     number__(
       (o(term), 'languages/bnl/sample-formula.term'),
       (i(term), 'languages/bnl/sample-number.tokens'),
       (u, [])
     )
   ),

   test(
     solve(
       (i(term), 'languages/bnl/sample-formula.term'),
       (o(term), 'languages/bnl/sample-value.term')
     )
   ),

   test(
     convert_(
       (i(term), 'languages/bnl/sample-number.term'),
       (o(term), 'languages/bnl/sample-value.term')
     )
   ),

   test(
     convert__(
       (i(term), 'languages/bnl/sample-number.term'),
       (o(term), 'languages/bnl/sample-formula.term')
     )
   ),

   test(
     parseBgl(
       (i(text), 'languages/bnl/cs.bgl'),
       (o(term), 'languages/bnl/cs.term')
     )
   ),

   test(
     bglToSignature(
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
       (i(term), 'languages/bnl/sample-number.term'),
       (u, number)
     )
   ),

   test(
     parseTopDownAndImplode(
       (i(term), 'languages/bnl/cs.term'),
       (u, number),
       (i(term), 'languages/bnl/sample-number.tokens'),
       (o(term), 'languages/bnl/sample-number.term')
     )
   )

)).
