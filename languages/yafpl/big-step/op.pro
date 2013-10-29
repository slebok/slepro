opVal(add, intval(I1), intval(I2), intval(I0)) :-
  I0 is I1 + I2.

opVal(sub, intval(I1), intval(I2), intval(I0)) :-
  I0 is I1 - I2.

opVal(mult, intval(I1), intval(I2), intval(I0)) :-
  I0 is I1 * I2.

opVal(eq, intval(I1), intval(I2), boolval(B0)) :-
  toBoolean((I1==I2), B0).
