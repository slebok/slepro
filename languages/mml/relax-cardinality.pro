% Turn all required members into optional members
relaxMetamodel(MM1, MM2) :-
  topdownGraph(relaxOne, MM1, MM2).

% Cardinality-level helper
relaxOne(X, Y) :-
  lookup(class, X, one),
  update(class, option, X, Y).
