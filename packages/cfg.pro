% Package CFG: Context-free grammars incl. parsing

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').

% Basic Grammar Language (BGL)
:- ['languages/bgl/accept-td.pro'].
:- ['languages/bgl/accept-bu.pro'].
:- ['languages/bgl/parse-td.pro'].
:- ['languages/bgl/unparse.pro'].
:- ['languages/bgl/implode.pro'].
:- ['languages/bgl/explode.pro'].
:- ['languages/bgl/derive-signature.pro'].
:- ['languages/bgl/run.pro'].

% Extended Grammar Language (EGL)
:- multifile xparse/5.
:- ['languages/egl/parse.pro'].
%:- ['languages/egl/parse-debug.pro']. % include for debugging parsing
:- ['languages/egl/scanner.pro'].
:- ['languages/egl/con2abs.pro'].
:- ['languages/egl/scannerfull.pro'].
:- ['languages/egl/scannerless.pro'].
:- ['languages/egl/run.pro'].

% Modules for sample languages
:- ['languages/expr/scanner.pro'].
:- ['languages/figure/scanner.pro'].
:- ['languages/figure/con2abs.pro'].
:- ['languages/mml/con2abs.pro'].
:- ['languages/ddl/scanner.pro'].
:- ['languages/ddl/con2abs.pro'].
:- ['languages/yafpl/con2abs.pro'].

% Test target

cfg_main :- runTests((

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Language EXPR
%

   test(
     exprScanner(
       (i(text), 'languages/expr/sample-add.expr'),
       (o(term), 'languages/expr/sample-add.tokens')
     )
   ),

   test(
     acceptTopDown(
       (i(term), 'languages/expr/consyn.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add.tokens')
     )
   ),

   test(
     acceptBottomUp(
       (i(term), 'languages/expr/consyn.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add.tokens')
     )
   ),

   test(
     parseTopDown(
       (i(term), 'languages/expr/consyn.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add.tokens'),
       (o(term), 'languages/expr/sample-add-ptree.term')
     )
   ),

   test(
     unparse(
       (i(term), 'languages/expr/sample-add-ptree.term'),
       (o(term), 'languages/expr/sample-add.tokens')
     )
   ),

   test(
     implode(
       (i(term), 'languages/expr/sample-add-ptree.term'),
       (o(term), 'languages/expr/sample-add-prefix.term')
     )
   ),

   test(
     explode(
       (i(term), 'languages/expr/consyn.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add-prefix.term'),
       (o(term), 'languages/expr/sample-add-ptree.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/bgl/abssyn.term'),
       (u, grammar),
       (i(term), 'languages/expr/consyn.term')
     )
   ),

   test(
     bglToSignature(
       (i(term), 'languages/expr/consyn.term'),
       (o(term), 'languages/expr/abssyn.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/consyn.term'),
       (u, metamodel),
       (i(term), 'languages/mml/lexsyn.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/expr/mm.mml'),
       (o(term), 'languages/expr/mm.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/consyn.term'),
       (u, metamodel),
       (i(term), 'languages/mml/lexsyn.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/expr/mm-relaxed.mml'),
       (o(term), 'languages/expr/mm-relaxed.term')
     )
   ),

   test(
     parseBgl(
       (i(text), 'languages/expr/consyn.bgl'),
       (o(term), 'languages/expr/consyn.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Language FIGURE
%

   test(
     scannerfullEgl(
       (i(text), 'languages/figure/consyn.egl'),
       (o(term), 'languages/figure/consyn.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/figure/lexsyn.egl'),
       (o(term), 'languages/figure/lexsyn.term')
     )
   ),

   test(
     tokens(
       (u, figureToken),
       (i(text), 'languages/figure/sample-line.figure'),
       (o(term), 'languages/figure/sample-line.tokens')
     )
   ),

   test(
     scannerfullParser(
       (i(term), 'languages/figure/consyn.term'),
       (u, figure),
       (u, fail),
       (i(term), 'languages/figure/sample-line.tokens'),
       (o(term), 'languages/figure/sample-line.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/figure/consyn.term'),
       (u, figure),
       (i(term), 'languages/figure/lexsyn.term'),
       (u, layout),
       (u, figureMapping),
       (i(text), 'languages/figure/sample-line.figure'),
       (o(term), 'languages/figure/sample-line.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/egl/abssyn.term'),
       (u, grammar),
       (i(term), 'languages/figure/consyn.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Metamodeling Language (MML)
%

   test(
     scannerfullEgl(
       (i(text), 'languages/mml/consyn.egl'),
       (o(term), 'languages/mml/consyn.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/mml/lexsyn.egl'),
       (o(term), 'languages/mml/lexsyn.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/consyn.term'),
       (u, metamodel),
       (i(term), 'languages/mml/lexsyn.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/family/mm1.mml'),
       (o(term), 'languages/family/mm1.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/consyn.term'),
       (u, metamodel),
       (i(term), 'languages/mml/lexsyn.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/family/mm2.mml'),
       (o(term), 'languages/family/mm2.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/mml/abssyn.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/mml/abssyn.term'),
       (u, metamodel),
       (i(term), 'languages/family/mm2.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/consyn.term'),
       (u, metamodel),
       (i(term), 'languages/mml/lexsyn.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/mml/mm.mml'),
       (o(term), 'languages/mml/mm.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Data Definition Language (DDL)
%

   test(
     scannerlessEgl(
       (i(text), 'languages/ddl/consyn.egl'),
       (o(term), 'languages/ddl/consyn.term')
     )
   ),

   test(
     tokens(
       (u, tablesToken),
       (i(text), 'languages/family/dd.ddl'),
       (o(term), 'languages/family/dd.tokens')
     )
   ),

   test(
     scannerfullParser(
       (i(term), 'languages/ddl/consyn.term'),
       (u, schema), (u, tablesMapping),
       (i(term), 'languages/family/dd.tokens'),
       (o(term), 'languages/family/dd.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Yet Another Functional Programming Language (YAFPL)
%

   test(
     scannerfullEgl(
       (i(text), 'languages/yafpl/consyn.egl'),
       (o(term), 'languages/yafpl/consyn.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/yafpl/lexsyn.egl'),
       (o(term), 'languages/yafpl/lexsyn.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/yafpl/consyn.term'),
       (u, program),
       (i(term), 'languages/yafpl/lexsyn.term'),
       (u, layout),
       (u, yafplMapping),
       (i(text), 'languages/yafpl/sample-factorial.hs'),
       (o(term), 'languages/yafpl/sample-factorial.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Basic Grammar Language (BGL)
%

   test(
     appliedSignature(
       (i(term), 'languages/bgl/abssyn.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/esl/abssyn.term'),
       (u, signature),
       (i(term), 'languages/bgl/abssyn.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Extended Grammar Language (EGL)
%

   test(
     scannerfullEgl(
       (i(text), 'languages/egl/consyn.egl'),
       (o(term), 'languages/egl/consyn.term')
     )
   ),

   test(
     scannerlessEgl(
       (i(text), 'languages/egl/consyn.egl'),
       (o(term), 'languages/egl/consyn.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/egl/lexsyn.egl'),
       (o(term), 'languages/egl/lexsyn.term')
     )
   ),

   test(
     scannerlessEgl(
       (i(text), 'languages/egl/lexsyn.egl'),
       (o(term), 'languages/egl/lexsyn.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/egl/abssyn.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/esl/abssyn.term'),
       (u, signature),
       (i(term), 'languages/egl/abssyn.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/egl/abssyn.term'),
       (u, grammar),
       (i(term), 'languages/egl/consyn.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/egl/abssyn.term'),
       (u, grammar),
       (i(term), 'languages/egl/lexsyn.term')
     )
   )

)).
