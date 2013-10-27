% Package PLT: Programming Language Theory

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').

% Package contributions
:- ['languages/yafpl/ok-prog.pro'].
:- ['languages/yafpl/ok-fun.pro'].
:- ['languages/yafpl/ok-expr.pro'].
:- ['languages/yafpl/ok-op.pro'].
:- ['languages/yafpl/big.pro'].
:- ['languages/yafpl/value.pro'].
:- ['languages/yafpl/op-value.pro'].
:- ['languages/yafpl/op-const.pro'].
:- ['languages/yafpl/small.pro'].
:- ['languages/yafpl/normal.pro'].
:- ['languages/yafpl/substitution.pro'].
:- ['languages/yafpl/reduction.pro'].
:- ['languages/yafpl/fun-prog.pro'].
:- ['languages/yafpl/fun-expr.pro'].
:- ['languages/yafpl/fun-combinators.pro'].

% Test target

plt_main :- runTests((

   test(
     wellTypedTerm(
       (i(term), 'languages/yafpl/abssyn.term'),
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
