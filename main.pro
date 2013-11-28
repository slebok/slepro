% Load the prelude of SLEPRO
:- ['prelude/data.pro'].
:- ['prelude/higher-order.pro'].
:- ['prelude/io.pro'].
:- ['prelude/test.pro'].
:- ['prelude/scanning.pro'].
:- ['prelude/http.pro'].
:- ['prelude/ueber.pro'].         

% UEBER-based processing of all code
:- init.
:- preprocess(languages).
:- run.
:- halt.
