% Package FSM: Finite State Machines

% Imports
:- ensure_loaded('packages/prelude.pro').
:- ensure_loaded('packages/term.pro').
:- ensure_loaded('packages/cfg.pro').
:- ensure_loaded('packages/dgl.pro').
:- ensure_loaded('packages/java.pro').

% Modules for FSM
:- ['languages/fsm/cs-to-as.pro'].
:- ['languages/fsm/ok.pro'].
:- ['languages/fsm/ok/distinct.pro'].
:- ['languages/fsm/ok/resolvable.pro'].
:- ['languages/fsm/ok/deterministic.pro'].
:- ['languages/fsm/ok/reachable.pro'].
:- ['languages/fsm/ok/closure.pro'].
:- ['languages/fsm/fsm-to-dgl.pro'].
:- ['languages/fsm/simulation.pro'].
:- ['languages/fsm/fsm-to-java/state.pro'].
:- ['languages/fsm/fsm-to-java/input.pro'].
:- ['languages/fsm/fsm-to-java/action.pro'].
:- ['languages/fsm/fsm-to-java/stepper.pro'].

% Test target

fsm_main :- runTests((

   test(
     scannerfullEgl(
       (i(text), 'languages/fsm/cs.egl'),
       (o(term), 'languages/fsm/cs.term')
     )
   ),

   test(
     scannerfullEgl(
       (i(text), 'languages/fsm/ls.egl'),
       (o(term), 'languages/fsm/ls.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/esl/cs.term'),
       (u, signature),
       (i(term), 'languages/esl/ls.term'),
       (u, layout),
       (u, eslMapping),
       (i(text), 'languages/fsm/as.esl'),
       (o(term), 'languages/fsm/as.term')
     )
   ),

   test(
     appliedSignature(
       (i(term), 'languages/fsm/as.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/fsm/as.term'),
       (u, fsm),
       (i(term), 'languages/fsm/sample-turnstile-fsm.term')
     )
   ),

   test(
     scannerlessParser(
       (i(term), 'languages/fsm/cs.term'),
       (u, fsm),
       (i(term), 'languages/fsm/ls.term'),
       (u, layout),
       (u, fsmMapping),
       (i(text), 'languages/fsm/sample-turnstile.fsm'),
       (o(term), 'languages/fsm/sample-turnstile-fsm.term')
     )
   ),

   test(
     okFsm(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term')
     )
   ),

   test(
     fsmToDgl(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term'),
       (o(term), 'languages/fsm/sample-turnstile-dgl.term')
     )
   ),

   test(
     ppDgl(
       (i(term), 'languages/fsm/sample-turnstile-dgl.term'),
       (o(text), 'languages/fsm/sample-turnstile.dot')
     )
   ),

   test(
     simulateFsm(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term'),
       (i(term), 'languages/fsm/sample-turnstile-input.term'),
       (o(term), 'languages/fsm/sample-turnstile-output.term')
     )
   ),

   test(
     statesOfFsm(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term'),
       (o(text), 'languages/fsm/java/State.java')
     )
   ),

   test(
     inputsOfFsm(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term'),
       (o(text), 'languages/fsm/java/Input.java')
     )
   ),

   test(
     actionsOfFsm(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term'),
       (o(text), 'languages/fsm/java/Action.java')
     )
   ),

   test(
     stepperOfFsm(
       (i(term), 'languages/fsm/sample-turnstile-fsm.term'),
       (u, 'TurnstileStepper'),
       (o(text), 'languages/fsm/java/TurnstileStepper.java')
     )
   )   

)).
