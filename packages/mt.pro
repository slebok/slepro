% Package MT: Model transformations

% Imports
:- ensure_loaded('../packages/prelude.pro').
:- ensure_loaded('../packages/mm.pro').

% The classes-to-tables transformation
:- ['../languages/mml/mappable.pro'].
:- ['../languages/mml/to-ddl/class-to-table.pro'].
:- ['../languages/mml/to-ddl/single-to-table.pro'].
:- ['../languages/mml/to-ddl/multi-to-table.pro'].

% Model editing
:- ['../languages/mml/editing/new-object.pro'].
:- ['../languages/mml/editing/add-object.pro'].
:- ['../languages/mml/editing/remove-object.pro'].

% Model evolution
:- ['../languages/mml/relax-cardinality.pro'].
:- ['../languages/mml/recardinalize.pro'].
:- ['../languages/mml/obj-add-key.pro']. % TODO: Needed? Appropriate?
:- ['../languages/mml/obj-remove-key.pro']. % TODO: Needed? Appropriate?
:- ['../languages/mml/atom-to-ref.pro'].
:- ['../languages/mml/model-atom-to-ref.pro'].
:- ['../languages/mml/coupling-atom-to-ref.pro'].

% Test target

mt_main :- runTests((

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Classes-to-tables transformation
%

   test(
     simpleMetamodel(
       (i(term), 'languages/family/mm2.term')
     )
   ),

   test(
     classesToTables(
       (i(term), 'languages/family/mm2.term'),
       (o(term), 'languages/family/dd.term')
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Metamodel relaxation for expr sample
%

   test(
     relaxMetamodel(
       (i(term), 'languages/expr/mm.graph'),
       (o(term), 'languages/expr/mm-relaxed.graph', graphEq)
     )
   ),

   test(
     recardinalize(
       (i(term), 'languages/expr/mm.graph'),
       (i(term), 'languages/expr/mm-relaxed.graph'),
       (i(term), 'languages/expr/sample-add.graph'),
       (o(term), 'languages/expr/sample-add-relaxed.graph', graphEq)
     )
   ),

   test(
     recardinalize(
       (i(term), 'languages/expr/mm-relaxed.graph'),
       (i(term), 'languages/expr/mm.graph'),
       (i(term), 'languages/expr/sample-add-relaxed.graph'),
       (o(term), 'languages/expr/sample-add.graph', graphEq)
     )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Model evolution for family sample
%

   test(
     atomToRef(
         (u, person),
         (u, person),
         (u, closestFriend),
         (u, firstName),
         (i(term), 'languages/family/sample-small-mm1.graph'),
         (i(term), 'languages/family/mm1.graph'),
         (o(term), 'languages/family/sample-small-mm2.graph', graphEq),
         (o(term), 'languages/family/mm2.graph', graphEq)
      )
   ),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Editing capabilities
%

   test(
     newObject(
       (i(term), 'languages/expr/mm.graph'),
       (u, add),
       (o(term), 'languages/expr/new-add.graph', graphEq)
     )
   ),

   test(
     concreteClassesForMember(
       (i(term), 'languages/expr/mm.graph'),
       (u, add),
       (u, left),
       (u, [const, add])
     )
   )

)).
