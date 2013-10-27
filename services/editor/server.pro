% Service Editor: Structured editor

% Import
:- ensure_loaded('../../packages/prelude.pro').
:- ensure_loaded('../../packages/mm.pro').
:- ensure_loaded('../../packages/mt.pro').
:- ensure_loaded('../../packages/pp.pro').

% Runtime for editor
:- ['runtime.pro'].

% Pages
:- ['metamodels.pro'].
:- ['classes.pro'].
:- ['new.pro'].
:- ['add.pro'].
:- ['remove.pro'].
:- ['edit.pro'].
:- ['show.pro'].

% Metamodels
:- loadMetamodel('../../languages/expr/mm.graph').
:- loadMetamodel('../../languages/family/mm1.graph').
:- loadMetamodel('../../languages/mml/mm.graph').

% Session handling
:- assertz(session(0)).

% Handlers
editor_handlers :-
  http_handler(root('metamodels'), metamodels_page, []),
  http_handler(root('classes'), classes_page, []),
  http_handler(root('edit'), edit_page, []),
  http_handler(root('show'), show_page, []),
  http_handler(root('new'), new_page, []),
  http_handler(root('add'), add_page, []),
  http_handler(root('remove'), remove_page, []).

% Server
editor_main :-
  service_http(editor_handlers).
