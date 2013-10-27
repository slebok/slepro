treeToGraph(Tree, (Root, Nodes, Next)) :-
  treeToGraph(Tree, (Root, Nodes), 0, Next).

treeToGraph(I, (X, [(X, I)]), X, Y) :-
  integer(I),
  Y is X + 1.

treeToGraph(Trees, (X, [(X, Roots)|Nodes]), X, Z) :-
  list(Trees), 
  Y is X + 1,
  seq(treeToGraph, Trees, Graphs, Y, Z),
  unzip(Graphs, Roots, Nodess),
  concat(Nodess, Nodes).

treeToGraph(Tree, (X, [(X, Slice)|Nodes]), X, Z) :-
  \+ integer(Tree),
  \+ list(Tree),
  Y is X + 1,
  Tree =.. [F|Trees],
  seq(treeToGraph, Trees, Graphs, Y, Z),
  unzip(Graphs, Roots, Nodess),
  concat(Nodess, Nodes),
  Slice =.. [F|Roots].
