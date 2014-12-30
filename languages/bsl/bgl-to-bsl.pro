% Convert a grammar to a signature
bglToBsl(Rules, Profiles) :-
   map(rule2profile, Rules, Profiles).

% Convert a rule to a profile
rule2profile((LabelOrFun, LhsOrRes, Rhs), (LabelOrFun, Args, LhsOrRes)) :-
  rhs2args(Rhs, Args).

% Base case
rhs2args([], []).

% Terminals are not represented by the signature
rhs2args([t(_)|Rhs], Args) :-
  rhs2args(Rhs, Args).

% Nonterminals are mapped to sorts
rhs2args([n(Sort)|Rhs], [Sort|Args]) :-
  rhs2args(Rhs, Args).
