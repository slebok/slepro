% Package DICT: Dictionaries

% Imports
:- ensure_loaded('../packages/prelude.pro').

% Package contributions
:- ['../languages/dict/abssyn.pro'].
:- ['../languages/dict/conversion.pro'].
:- multifile permute/2.
:- multifile key/2.
:- multifile lookup/3.
:- multifile add/4.
:- multifile update/4.
:- multifile remove/3.
:- ['../languages/dict/crud.pro'].

% Test target; TODO: add tests / illustrations for API

dict_main :- runTests((

   true

)).
