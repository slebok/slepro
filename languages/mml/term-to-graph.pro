metamodelToGraph(
  (Name, Ts),
  G
) :-
     map(classifierToGraph, Ts, Gs),
     G = { 
       class : metamodel,
       name : Name,
       classifiers : Gs
     },
     require(
       illFormedGraph,
       graph(G)).

classifierToGraph(
  datatype(Name),
  Name & {
    class : datatype,
    name : Name
  }
).

classifierToGraph(
  class(Abstr, Name, SuperT, Ts),
  Name & {
    class : class,
    name : Name,
    abstract : Abstr,
    super : SuperG,
    members : Gs
  }
) :-
     superToGraph(SuperT, SuperG),
     map(memberToGraph, Ts, Gs).

superToGraph([], []).
superToGraph([Name], [#Name]).

memberToGraph(
  (Kind, Name, Type, Card),
  {
    class : Kind,
    name : Name,
    type : # Type,
    cardinality : { class : Card }
  }
).
