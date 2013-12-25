# The ueber-based test approach
test:
	@swipl -q -f main.pro

# Force file creation
create:
	@swipl -q -f main.pro -- create

# Force file overriding
override:
	@swipl -q -f main.pro -- override

# create and override combined
force:
	@swipl -q -f main.pro -- create override

# Broken, old tests; still some porting needed
test-old:
	make prelude.test
	make term.test
	make cfg.test
	make dict.test
	make graph.test
	make mm.test
	make mt.test
	make plt.test
	make dgl.test
	make java.test

%.test:
	@echo Testing package $* ...
	@swipl -q -f packages/$*.pro -g $*_main

