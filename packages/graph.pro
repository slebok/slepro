% Package GRAPHS: Graphs as generalization of dictionaries

% Imports
:- ensure_loaded('../packages/prelude.pro').
:- ensure_loaded('../packages/dict.pro').

% Package contributions
:- ['../languages/graph/from-term.pro']. % TODO: properly motivate; move elsewhere?
:- ['../languages/graph/to-term.pro']. % TODO: properly motivate; move elsewhere?
:- ['../languages/graph/abssyn.pro'].
:- ['../languages/graph/conversion.pro'].
:- ['../languages/graph/crud.pro'].
:- ['../languages/graph/normal.pro'].
:- ['../languages/graph/deref.pro'].
:- ['../languages/graph/iterate.pro'].
:- ['../languages/graph/search.pro'].

% Test target; TODO: add tests / illustrations for API

graph_main :- runTests((

   test(
     graph(
       (i(term), 'languages/family/sample-empty-mm2.graph')
     )
   ),

   test(
     graph(
       (i(term), 'languages/family/sample-singleton-mm2.graph')
     )
   ),

   test(
     graph(
       (i(term), 'languages/family/sample-small-mm2.graph')
     )
   ),

   test(
     graph(
       (i(term), 'languages/family/mm1.graph')
     )
   ),

   test(
     graph(
       (i(term), 'languages/family/mm2.graph')
     )
   )

)).

/*

TODO: Reenable these tests?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Terms to graphs and back
%

   test(
     'mankind-class.term converts to mankind-class.graph',
     applyToIO(treeToGraph, [
         (i(term), 'mankind-class.term'),
         (o(term), 'mankind-class.graph')
       ])
   ),

   test(
     'mankind-class.graph converts to mankind-class.term',
     applyToIO(graphToTree, [
         (i(term), 'mankind-class.graph'), 
         (o(term), 'mankind-class.term')
       ])
   ),
*/
