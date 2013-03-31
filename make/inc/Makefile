include my.inc
.PHONY: clean gen
my.inc:
	@echo "var = abc" > $@

out: my.inc
	@echo $(var)

clean:
	@rm -rf my.inc

