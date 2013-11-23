readTextFile(File, Text) :-
  require(
    fileExpected(File),
    open(File, read, Input, [])
  ),
  read_stream_to_codes(Input, Text),
  close(Input).

readTermFile(File, Term) :-
  require(
    fileExpected(File),
    open(File, read, Input, [])
  ),
  require(
    fileWithPrologTermExpected(File),
    read(Input, Term)
  ),
  close(Input).
