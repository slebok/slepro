% Package PLT: Programming Language Theory

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').

% Wellness
:- ['languages/yafpl/wellness/prog.pro'].
:- ['languages/yafpl/wellness/fun.pro'].
:- ['languages/yafpl/wellness/expr.pro'].
:- ['languages/yafpl/wellness/op.pro'].

% Big-step semantics
:- ['languages/yafpl/big-step/evaluate.pro'].
:- ['languages/yafpl/big-step/value.pro'].
:- ['languages/yafpl/big-step/op.pro'].

% Small-step semantics
:- ['languages/yafpl/small-step/step.pro'].
:- ['languages/yafpl/small-step/reduction.pro'].
:- ['languages/yafpl/small-step/op.pro'].
:- ['languages/yafpl/small-step/normal.pro'].
:- ['languages/yafpl/small-step/substitution.pro'].

% Denotation semantics
:- ['languages/yafpl/denotational/prog.pro'].
:- ['languages/yafpl/denotational/expr.pro'].
:- ['languages/yafpl/denotational/combinators.pro'].

% Test target

plt_main :- runTests((

   test(
     wellTypedTerm(
       (i(term), 'languages/yafpl/as.term'),
       (u, program),
       (i(term), 'languages/yafpl/sample-factorial.term')
     )
   ),

   test(
     okProg(
       (i(term), 'languages/yafpl/sample-factorial.term')
     )
   ),

   test(
     evaluate(
       (i(term), 'languages/yafpl/sample-factorial.term'),
       (u, []),
       (u, apply(factorial, [intconst(5)])),
       (u, intval(120))
     )
   ),

   test(
     reduce(
       (i(term), 'languages/yafpl/sample-factorial.term'),
       (u, apply(factorial, [intconst(5)])),
       (u, intconst(120))
     )
   ),

   test(
     meaningProg(
       (i(term), 'languages/yafpl/sample-factorial.term'),
       (u, apply(factorial, [intconst(5)])),
       (u, intval(120))
     )
   )

)).
