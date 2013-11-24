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
:- ['languages/bgl/api.pro'].

% Extended Grammar Language (EGL)
:- ['languages/egl/parse.pro'].
%:- ['languages/egl/parse-debug.pro']. % include for debugging parsing
:- ['languages/egl/scanner.pro'].
:- ['languages/egl/cs-to-as.pro'].
:- ['languages/egl/api.pro'].

% Modules for sample languages
:- ['languages/expr/scanner.pro'].
:- ['languages/figure/scanner.pro'].
:- ['languages/figure/cs-to-as.pro'].
:- ['languages/esl/cs-to-as.pro'].
:- ['languages/mml/cs-to-as.pro'].
:- ['languages/ddl/scanner.pro'].
:- ['languages/ddl/cs-to-as.pro'].
:- ['languages/yafpl/cs-to-as.pro'].

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
       (i(term), 'languages/expr/cs.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add.tokens')
     )
   ),

   test(
     acceptBottomUp(
       (i(term), 'languages/expr/cs.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add.tokens')
     )
   ),

   test(
     parseTopDown(
       (i(term), 'languages/expr/cs.term'),
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
       (i(term), 'languages/expr/cs.term'),
       (u, expr),
       (i(term), 'languages/expr/sample-add-prefix.term'),
       (o(term), 'languages/expr/sample-add-ptree.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/bgl/as.term'),
       (u, grammar),
       (i(term), 'languages/expr/cs.term')
     )
   ),

   test(
     bglToBsl(
       (i(term), 'languages/expr/cs.term'),
       (o(term), 'languages/expr/as.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/cs.term'),
       (u, metamodel),
       (i(term), 'languages/mml/ls.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/expr/mm.mml'),
       (o(term), 'languages/expr/mm.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/cs.term'),
       (u, metamodel),
       (i(term), 'languages/mml/ls.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/expr/mm-relaxed.mml'),
       (o(term), 'languages/expr/mm-relaxed.term')
     )
   ),

   test(
     parseBgl(
       (i(text), 'languages/expr/cs.bgl'),
       (o(term), 'languages/expr/cs.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Language FIGURE
%

   test(
     scannerfullEgl(
       (i(text), 'languages/figure/cs.egl'),
       (o(term), 'languages/figure/cs.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/figure/ls.egl'),
       (o(term), 'languages/figure/ls.term')
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
       (i(term), 'languages/figure/cs.term'),
       (u, figure),
       (u, fail),
       (i(term), 'languages/figure/sample-line.tokens'),
       (o(term), 'languages/figure/sample-line.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/figure/cs.term'),
       (u, figure),
       (i(term), 'languages/figure/ls.term'),
       (u, layout),
       (u, figureMapping),
       (i(text), 'languages/figure/sample-line.figure'),
       (o(term), 'languages/figure/sample-line.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/egl/as.term'),
       (u, grammar),
       (i(term), 'languages/figure/cs.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Metamodeling Language (MML)
%

   test(
     scannerfullEgl(
       (i(text), 'languages/mml/cs.egl'),
       (o(term), 'languages/mml/cs.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/mml/ls.egl'),
       (o(term), 'languages/mml/ls.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/cs.term'),
       (u, metamodel),
       (i(term), 'languages/mml/ls.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/family/mm1.mml'),
       (o(term), 'languages/family/mm1.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/cs.term'),
       (u, metamodel),
       (i(term), 'languages/mml/ls.term'),
       (u, layout),
       (u, classesMapping),
       (i(text), 'languages/family/mm2.mml'),
       (o(term), 'languages/family/mm2.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/mml/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/mml/as.term'),
       (u, metamodel),
       (i(term), 'languages/family/mm2.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/mml/cs.term'),
       (u, metamodel),
       (i(term), 'languages/mml/ls.term'),
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
       (i(text), 'languages/ddl/cs.egl'),
       (o(term), 'languages/ddl/cs.term')
     )
   ),

   test(
     tokens(
       (u, tablesToken),
       (i(text), 'languages/family/dd.sql'),
       (o(term), 'languages/family/dd.tokens')
     )
   ),

   test(
     scannerfullParser(
       (i(term), 'languages/ddl/cs.term'),
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
       (i(text), 'languages/yafpl/cs.egl'),
       (o(term), 'languages/yafpl/cs.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/yafpl/ls.egl'),
       (o(term), 'languages/yafpl/ls.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/yafpl/cs.term'),
       (u, program),
       (i(term), 'languages/yafpl/ls.term'),
       (u, layout),
       (u, yafplMapping),
       (i(text), 'languages/yafpl/sample-factorial.hs'),
       (o(term), 'languages/yafpl/sample-factorial.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Extended Signature Language (ESL)
%

   test(
     scannerlessEgl(
       (i(text), 'languages/esl/cs.egl'),
       (o(term), 'languages/esl/cs.term')
     )
   ),

   test(
     scannerlessEgl(
       (i(text), 'languages/esl/ls.egl'),
       (o(term), 'languages/esl/ls.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Basic Grammar Language (BGL)
%

   test(
     appliedSignature(
       (i(term), 'languages/bgl/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/esl/as.term'),
       (u, signature),
       (i(term), 'languages/bgl/as.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Extended Grammar Language (EGL)
%

   test(
     scannerfullEgl(
       (i(text), 'languages/egl/cs.egl'),
       (o(term), 'languages/egl/cs.term')
     )
   ),

   test(
     scannerlessEgl(
       (i(text), 'languages/egl/cs.egl'),
       (o(term), 'languages/egl/cs.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/egl/ls.egl'),
       (o(term), 'languages/egl/ls.term')
     )
   ),

   test(
     scannerlessEgl(
       (i(text), 'languages/egl/ls.egl'),
       (o(term), 'languages/egl/ls.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/egl/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/esl/as.term'),
       (u, signature),
       (i(term), 'languages/egl/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/egl/as.term'),
       (u, grammar),
       (i(term), 'languages/egl/cs.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/egl/as.term'),
       (u, grammar),
       (i(term), 'languages/egl/ls.term')
     )
   )

)).
