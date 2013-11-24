% Natural numbers
signature(

  % Sorts of this signature
  [nat],

  % Symbol types
  [ symbol(zero, [], nat),
    symbol(succ, [nat], nat)
  ]
).
