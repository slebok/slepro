% Package Term: Terms based on algebraic signatures

% Import
:- ensure_loaded('../packages/prelude.pro').

% Term representations
:- ['../languages/bsl/tuple-term.pro'].
:- ['../languages/bsl/prefix-term.pro'].
:- ['../languages/esl/applied-term.pro'].

% Basic signatures
:- ['../languages/bsl/as.pro'].
:- ['../languages/bsl/conformance.pro'].

% Applied terms and signatures
:- ['../languages/esl/as.pro'].
:- ['../languages/esl/conformance.pro'].

% Test target

term_main :- runTests((

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% Basic term tests
%

   test(
     appliedTerm(
       (i(term), 'languages/figure/sample-line.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Conformance with a signature
%

   test(
     signature(
       (i(term), 'languages/expr/as.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Applied terms and signatures
%

   test(
     appliedSignature(
       (i(term), 'languages/figure/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/figure/as.term'),
       (u, figure),
       (i(term), 'languages/figure/sample-line.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/esl/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/esl/as.term'),
       (u, signature),
       (i(term), 'languages/figure/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/esl/as.term'),
       (u, signature),
       (i(term), 'languages/esl/as.term')
     )
   )

)).
