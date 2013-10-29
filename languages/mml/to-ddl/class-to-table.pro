% Map classes to tables
classesToTables((_, Classifiers), Tables3) :-
  map(classToTable, Classifiers, Tabless1),
  concat(Tabless1, Tables1),
  map(multisToTables, Classifiers, Tabless2),
  concat(Tabless2, Tables2),
  append(Tables1, Tables2, Tables3).

% Map each class to a table
classToTable(

  class(
    false, % Map concrete classes, only
    Name, 
    [], % Map non-extended classes, only
    Members),

  [ (Name,
     [ PrimaryKey % Standard column for primary key
     | Columns % Columns for single-valued members
     ] ) ] )

 :-
    PrimaryKey = (
        objectId, % Standardized name of column
        integer, % Standardized primary key type
        [notNull, primaryKey] % SQL DDL modifiers
      ),
    map(singleToColumn, Members, Columnss),
    concat(Columnss, Columns).

% Skip datatypes
classToTable(datatype(_), []).
