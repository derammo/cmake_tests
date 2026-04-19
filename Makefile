.PHONY: test

test: cmake/main.make
	@failed=0; passed=0; \
	for t in tests/test_*.sh; do \
		printf '==> %s\n' "$$t"; \
		if sh "$$t"; then \
			passed=$$((passed+1)); \
		else \
			failed=$$((failed+1)); \
		fi; \
	done; \
	echo; \
	echo "passed: $$passed  failed: $$failed"; \
	[ $$failed -eq 0 ]

cmake/main.make:
	git submodule update --init --recursive
