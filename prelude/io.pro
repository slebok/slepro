readTextFile(File, Text) :-
  require(
    fileExpected(File),
    open(File, read, Input, [])
  ),
  read_stream_to_codes(Input, Text),
  close(Input).

writeTextFile(File, Text) :-
  open(File, write, Output, []),
  format(Output, '~s', [Text]),
  close(Output).

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

writeTermFile(File, Term) :-
  open(File, write, Output, []),
  format(Output, '~q.', [Term]),
  close(Output).
