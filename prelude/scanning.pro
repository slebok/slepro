% Map string to token sequence 
tokens(
    TPred, % predicate for invidual tokens
    SPred, % predicate for tokens to be skipped
    Input, % the input string
    Ts % the resulting token sequence
  ) :- 
       tokens_(TPred, SPred, Ts, Input, []).

% Default for SPred to consume spaces
tokens(TPred, Input, Ts) :-
  tokens(TPred, star(char(space)), Input, Ts).

% Lists of tokens with spaces (possibly) 
tokens_(TPred, SPred, [T|Ts], I1, I4) :-
  apply(SPred, [I1, I2]),
  apply(TPred, [T, I2, I3]),
  tokens_(TPred, SPred, Ts, I3, I4).
tokens_(_, SPred, [], I1, I2) :- 
  apply(SPred, [I1, I2]).

% Character classification in DCG notation
char(Type, [H|T], T) :-
  char_type(H, Type).

% Variation on char/3 to return character
char(Type, H, [H|T], T) :-
  char_type_(H, Type).

% Extension of char_type/2
char_type_(Char, Type) :-
 Type == noQuote -> 
     \+ char_type(Char, quote)
   ; char_type(Char, Type).

% Variation on but/3 to return consumed character
but(Chars, H, [H|T], T) :-
  \+ member(H, Chars).
