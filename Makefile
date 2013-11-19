test:
	make prelude.test
	make term.test
	make cfg.test
	make pp.test
	make dict.test
	make graph.test
	make mm.test
	make mt.test
	make plt.test
	make fsml.test
	make dgl.test
	make bnl.test

%.test:
	@echo Testing package $* ...
	@swipl -q -f packages/$*.pro -g $*_main

# The new ueber-approach
ueber:
	swipl -f .ueber

