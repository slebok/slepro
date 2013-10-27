% Classes of a metamodel
classesOfMetamodel(MM, CNames) :-
  lookup(classifiers, MM, Classes),
  findall(CName,
    (
      member(Class, Classes),
      lookup(class, Class, class),
      lookup(name, Class, CName)
    ),
    CNames).

% Concrete classes of metamodel
concreteClassesOfMetamodel(MM, CNames) :-
  lookup(classifiers, MM, Classes),
  findall(CName,
    (
      member(Class, Classes),
      lookup(class, Class, class),
      lookup(name, Class, CName),
      lookup(abstract, Class, false)
    ),
    CNames).

% Concrete classes with a certain base class
concreteClassesOfMetamodel(MM, Bound, CNames) :-
  lookup(classifiers, MM, Classes),
  findall(CName,
    (
      member(Class, Classes),
      lookup(class, Class, class),
      lookup(name, Class, CName),
      lookup(abstract, Class, false),
      subclassOf(MM, CName, Bound)
    ),
    CNames).

% Concrete classes for a member
concreteClassesForMember(MM, CName, MName, CNames) :-
  lookupMember(CName, MName, MM, M),
  lookup(type, M, #Ref),
  getObject(MM, Ref, Class),
  lookup(name, Class, Bound),
  concreteClassesOfMetamodel(MM, Bound, CNames).
