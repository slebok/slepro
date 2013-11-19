:- ['cs.dcg'].
:- ['conversion1.dcg'].
:- ['conversion2.dcg'].
:- ['solver.pro'].

test("0").
test("1").
test("10").
test("11").
test("100").
test("101").
test("101.01").

:- (
     test(X),
     number(X,[]),
     number(V1,X,[]),
     number_(F,X,[]),
     solve(F, V2),
     format('~s --> ~w (~w)~n',[X, V1, V2]),
     fail
   ;
     halt
   ).
