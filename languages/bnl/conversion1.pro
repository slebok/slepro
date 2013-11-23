:- use_module(library(clpr)).

asConvert_(number(Bits, Rest), Val0) :-
  convertBits_(Bits, Pos1, Len1, Val1),
  convertRest_(Rest, Val2),
  { Pos1 =:= Len1 - 1 },
  { Val0 =:= Val1 + Val2 }.

convertBits_(bit(Bit), Pos, Len, Val) :-
  convertBit_(Bit, Pos, Val),
  { Len =:= 1 }.

convertBits_(bits(Bit, Bits), Pos0, Len0, Val0) :-
  convertBit_(Bit, Pos0, Val1),
  convertBits_(Bits, Pos1, Len1, Val2),
  { Pos1 =:= Pos0 - 1 },
  { Len0 =:= Len1 + 1 },
  { Val0 =:= Val1 + Val2 }.

convertBit_(zero, _Pos, Val) :-
  { Val =:= 0 }.

convertBit_(one, Pos, Val) :-
  { Val =:= 2 ^ Pos }.

convertRest_(integer, Val) :-
  { Val =:= 0 }.

convertRest_(rational(Bits), Val) :-
  convertBits_(Bits, Pos, _Len, Val),
  { Pos =:= -1 }.
