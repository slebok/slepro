bglElementOf(File, I) :-
  bglParse(File, I, _).
bglParse(File, I, T) :-
  readTermFile(File, G),  
  G = grammar([R|_], _),
  parseTopDownAndImplode(G, R, I, T).

% Turn string into list of singleton character atoms
charsToTokens(String, L2) :-
  map(singleton, String, L1),
  map(flip(atom_codes), L1, L3).
