graphToTree((Ref, Nodes, _), Tree) :-
  refToTree(Nodes, Ref, Tree).

refToTree(Nodes, Ref, Tree) :-
  refToSlice(Nodes, Ref, Slice),
  sliceToTree(Nodes, Slice, Tree).

refToSlice(Nodes, Ref, Slice) :-
  member((Ref, Slice), Nodes).

sliceToTree(_, I, I) :-
  integer(I).
   
sliceToTree(Nodes, Refs, Trees) :-
  list(Refs), 
  map(refToTree(Nodes), Refs, Trees).

sliceToTree(Nodes, Slice, Tree) :-
  \+ integer(Slice),
  \+ list(Slice),
  Slice =.. [F|Refs],
  map(refToTree(Nodes), Refs, Trees),
  Tree =.. [F|Trees].
