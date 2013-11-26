% Package JAVA: Java subset used for some code generation

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').
:- ensure_loaded('packages/cfg.pro').
:- consult('languages/ppl/eval.pro').
:- consult('languages/ppl/to-string.pro').

% Modules for DGL
:- ['languages/java/as-to-cs.pro'].

% Test target

java_main :- runTests((

   test(
     appliedSignature(
       (i(term), 'languages/java/as.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/esl/cs.term'),
       (u, signature),
       (i(term), 'languages/esl/ls.term'),
       (u, layout),
       (u, eslMapping),
       (i(text), 'languages/java/as.esl'),
       (o(term), 'languages/java/as.term')
     )
   ),

   test(
     ppJavaDecl(
       (i(term), 'languages/java/sample-enum.term'),
       (o(text), 'languages/java/sample-enum.java')
     )
   )

)).
