% Package FSML: The FSM language

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').
:- ensure_loaded('packages/cfg.pro').
:- ensure_loaded('packages/dgl.pro').
:- ensure_loaded('packages/java.pro').

% Modules for FSM
:- ['languages/fsml/cs-to-as.pro'].
:- ['languages/fsml/ok.pro'].
:- ['languages/fsml/ok/distinct.pro'].
:- ['languages/fsml/ok/resolvable.pro'].
:- ['languages/fsml/ok/deterministic.pro'].
:- ['languages/fsml/ok/reachable.pro'].
:- ['languages/fsml/ok/closure.pro'].
:- ['languages/fsml/fsm-to-dgl.pro'].
:- ['languages/fsml/simulation.pro'].
:- ['languages/fsml/fsm-to-java/state.pro'].
:- ['languages/fsml/fsm-to-java/input.pro'].
:- ['languages/fsml/fsm-to-java/action.pro'].
:- ['languages/fsml/fsm-to-java/stepper.pro'].

% Test target

fsml_main :- runTests((

   test(
     scannerfullEgl(
       (i(text), 'languages/fsml/cs.egl'),
       (o(term), 'languages/fsml/cs.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/fsml/ls.egl'),
       (o(term), 'languages/fsml/ls.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/esl/cs.term'),
       (u, signature),
       (i(term), 'languages/esl/ls.term'),
       (u, layout),
       (u, eslMapping),
       (i(text), 'languages/fsml/as.esl'),
       (o(term), 'languages/fsml/as.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/fsml/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/fsml/as.term'),
       (u, fsm),
       (i(term), 'languages/fsml/sample-turnstile-fsm.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/fsml/cs.term'),
       (u, fsm),
       (i(term), 'languages/fsml/ls.term'),
       (u, layout),
       (u, fsmMapping),
       (i(text), 'languages/fsml/sample-turnstile.fsm'),
       (o(term), 'languages/fsml/sample-turnstile-fsm.term')
     )
   ),

   test(
     okFsm(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term')
     )
   ),

   test(
     fsmToDgl(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term'),
       (o(term), 'languages/fsml/sample-turnstile-dgl.term')
     )
   ),

   test(
     ppDgl(
       (i(term), 'languages/fsml/sample-turnstile-dgl.term'),
       (o(text), 'languages/fsml/sample-turnstile.dot')
     )
   ),

   test(
     simulateFsm(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term'),
       (i(term), 'languages/fsml/sample-turnstile-input.term'),
       (o(term), 'languages/fsml/sample-turnstile-output.term')
     )
   ),

   test(
     statesOfFsm(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term'),
       (o(text), 'languages/fsml/java/State.java')
     )
   ),

   test(
     inputsOfFsm(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term'),
       (o(text), 'languages/fsml/java/Input.java')
     )
   ),

   test(
     actionsOfFsm(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term'),
       (o(text), 'languages/fsml/java/Action.java')
     )
   ),

   test(
     stepperOfFsm(
       (i(term), 'languages/fsml/sample-turnstile-fsm.term'),
       (u, 'TurnstileStepper'),
       (o(text), 'languages/fsml/java/TurnstileStepper.java')
     )
   )   

)).
