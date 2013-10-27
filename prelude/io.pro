readTextFile(File, Text) :-
  open(File, read, Input, []),
  read_stream_to_codes(Input, Text),
  close(Input).

readTermFile(File, Term) :-
  open(File, read, Input, []),
  read(Input, Term),
  close(Input).
