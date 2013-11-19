convert__(number(Bits, Rest), Val1+Val2) :-
  convertBits__(Bits, Len1-1, Len1, Val1),
  convertRest__(Rest, Val2).

convertBits__(bit(Bit), Pos, 1, Val) :-
  convertBit__(Bit, Pos, Val).

convertBits__(bits(Bit, Bits), Pos0, Len1+1, Val1+Val2) :-
  convertBit__(Bit, Pos0, Val1),
  convertBits__(Bits, Pos0-1, Len1, Val2).

convertBit__(zero, _Pos, 0).

convertBit__(one, Pos, 2^Pos).

convertRest__(integer, 0).

convertRest__(rational(Bits), Val) :-
  convertBits__(Bits, -1, _Len, Val).
