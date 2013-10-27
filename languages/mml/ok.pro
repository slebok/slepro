% Wellness of metamodels
metamodelWell((_, Classifiers)) :-

  % Uniqueness of classifier names
  map(nameOfClassifier, Classifiers, Names),
  set(Names),

  % Wellness per classifier
  map(classifierWell(Classifiers), Classifiers).

% Projection of classifier to name
nameOfClassifier(class(_, Name, _, _), Name).
nameOfClassifier(datatype(Name), Name).

% Wellness of datatypes (trivial)
classifierWell(_, datatype(_)).

% Wellness of classes
classifierWell(
  Classifiers, % Context
  class(_, _, Extends, Members1))

 :-
    % Resolvability of "super"
    chaseMembers(Classifiers, Extends, Members2),

    % Uniqueness of member names
    append(Members1, Members2, Members3),
    map(nameOfMember, Members3, Names),
    set(Names),

    % Wellness per member 
    map(memberWell(Classifiers), Members1).

% Projection of member to name
nameOfMember((_, Name, _, _), Name).

% Wellness of values
memberWell(Classifiers, (value, _, Name, _)) :-
  member(datatype(Name), Classifiers).

% Wellness of parts
memberWell(Classifiers, (part, _, Name, _)) :-
  member(class(_,Name,_,_), Classifiers).

% Wellness of references
memberWell(Classifiers, (reference, _, Name, _)) :-
  member(class(_,Name,_,_), Classifiers).
