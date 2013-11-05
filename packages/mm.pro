% Package MM: Metamodeling

% Imports
:- ensure_loaded('../packages/prelude.pro').
:- ensure_loaded('../packages/term.pro').
:- ensure_loaded('../packages/dict.pro').
:- ensure_loaded('../packages/graph.pro').

% Metamodels at the term level
:- ['../languages/mml/as.pro'].
:- ['../languages/mml/term-chase.pro'].
:- ['../languages/mml/term-to-graph.pro'].

% Metamodels at the graph level
:- ['../languages/mml/graph-chase.pro'].
:- ['../languages/mml/crud.pro'].
:- ['../languages/mml/lists.pro'].
:- ['../languages/mml/ok.pro'].
:- ['../languages/mml/subclass.pro'].

% Conformance
:- ['../languages/mml/conformance/main.pro'].
:- ['../languages/mml/conformance/member.pro'].
:- ['../languages/mml/conformance/cardinality.pro'].

% Test target

mm_main :- runTests((

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Metamodels
%

   test(
     metamodel(
       (i(term), 'languages/expr/mm.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/mml/sample-mm1.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/mml/sample-mm2.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/mml/sample-mm3.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/mml/sample-mm4.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/family/mm1.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/family/mm2.graph')
     )
   ),

   test(
     metamodel(
       (i(term), 'languages/mml/mm.graph')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Conformance
%

   test(
     conforms(
       (i(term), 'languages/expr/sample-add.graph'), 
       (i(term), 'languages/expr/mm.graph')
     )
   ),

   test(
     conforms(
       (i(term), 'languages/expr/sample-add-relaxed.graph'), 
       (i(term), 'languages/expr/mm-relaxed.graph')
     )
   ),

   test(
     conforms(
       (i(term), 'languages/family/sample-empty-mm2.graph'), 
       (i(term), 'languages/family/mm2.graph')
     )
   ),

   test(
     conforms(
       (i(term), 'languages/family/sample-singleton-mm2.graph'), 
       (i(term), 'languages/family/mm2.graph')
     )
   ),

   test(
     conforms(
       (i(term), 'languages/family/sample-small-mm2.graph'), 
       (i(term), 'languages/family/mm2.graph')
     )
   ),

   test(
     conforms(
       (i(term), 'languages/mml/mm.graph'),
       (i(term), 'languages/mml/mm.graph')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/mml/as.term'),
       (u, metamodel),
       (i(term), 'languages/mml/mm.term')
     )
   ),

   test(
     wellTypedTerm(
       (i(term), 'languages/ddl/as.term'),
       (u, schema),
       (i(term), 'languages/family/dd.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Wellness beyond conformance to metametamodel
%

   test(
     metamodelWell(
       (i(term), 'languages/family/mm2.term')
     )
   ),

   test(
     metamodelWell(
       (i(term), 'languages/mml/mm.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Term to graph mapping
%

   test(
     metamodelToGraph(
       (i(term), 'languages/expr/mm.term'),
       (o(term), 'languages/expr/mm.graph', graphEq)
     )
   ),

   test(
     metamodelToGraph(
       (i(term), 'languages/expr/mm-relaxed.term'),
       (o(term), 'languages/expr/mm-relaxed.graph', graphEq)
     )
   ),

   test(
     metamodelToGraph(
       (i(term), 'languages/family/mm1.term'),
       (o(term), 'languages/family/mm1.graph', graphEq)
     )
   ),

   test(
     metamodelToGraph(
       (i(term), 'languages/family/mm2.term'),
       (o(term), 'languages/family/mm2.graph', graphEq)
     )
   ),

   test(
     metamodelToGraph(
       (i(term), 'languages/mml/mm.term'),
       (o(term), 'languages/mml/mm.graph', graphEq)
     )
   )
   
)).
