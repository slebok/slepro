% The prelude assumed by all other packages
:- ['../prelude/data.pro'].
:- ['../prelude/higher-order.pro'].
:- ['../prelude/io.pro'].
:- ['../prelude/test.pro'].
:- ['../prelude/scanning.pro'].
:- ['../prelude/http.pro'].

% Test target

% TODO: add many samples for higher-order magic etc.

prelude_main :- runTests((

   true

)).

