stepperOfFsm(Fsm, N, Text) :-
  findall(S,
    (
      % Iterate over states and transitions
      member((_, From, Ts), Fsm),
      member((I, A, To), Ts),

      % Construct expression for source state
      FE = select(name('State'), From),

      % Construct expression for input
      IE = select(name('Input'), I),

      % Construct expression for (optional) action
      ( A = [A1] ->
            AE = select(name('Action'), A1)
          ; AE = null
      ),

      % Construct expression for target state
      TE = select(name('State'), To),

      % Construct expression statement for "add"
      S = expression(call(add, [FE, IE, AE, TE]))
    ),
    Ss),

  % Construct handler assignment
  HA = assign(select(this, handler), name(handler)),

  % Construct state initialization
  SI = assign(name(state), select(name('State'),locked)),

  % Construct class
  Class = class(public, false, N, [],
    [ typeapp('Stepper', [
        typename('State'),
        typename('Input'),
        typename('Action')
      ] )
    ],
    [
      constr(
        public,
        [(typeapp('Handler', [typename('Action')]), handler)],
        [HA,SI|Ss])
    ] ),

  % Render the class
  ppJavaDecl(Class, Text).
