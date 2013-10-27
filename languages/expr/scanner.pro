% Keywords and special characters
exprToken(Atom) -->
  {
    member(String,
      ["zero", "succ", "(", ")", "+"]),
    name(Atom, String) 
  },
  String.
