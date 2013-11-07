# Yet Another Functional Programming Language

This folder contains the specification/implementation of YAFPL, a small subset of Haskell

* [cs.egl](cs.egl) specifies the concrete syntax of the language
* [ls.egl](ls.egl) specifies the lexical syntax of the language
* [cs-to-as.pro](cs-to-as.pro) maps (implodes) concrete syntax trees to abstract syntax trees
* [as.term](as.term) specifies the signature of the abstract syntax 
* [as-to-cs.pro](as-to-cs.pro) maps (unparses) abstract syntax trees to concrete syntax trees 

* [sample-factorial.hs](sample-factorial.hs) is a small example program

* [bigstep](bigstep/) contains dynamic semantics specified as big-step rules
* [smallstep](smallstep/) contains dynamics semantics specified as small-step rules
* [denotational](denotational/) contains a denotational semantics specification of dynamic semantics
* [wellness](wellness/) contains static semantics, disguised as a wellness-checker (typechecker)

The `*.term` files contain Prolog terms, usually the AST or CST of the corresponding file.
