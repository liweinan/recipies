words := he the hen other the%

.PHONY: get-the

get-the:
	@echo $(filter "he", $(words))
	@echo $(filter %he, $(words))
	@echo $(filter he%, $(words))
	@echo $(filter %he%, $(words))

sources := count_words.c counter.c lexer.c
objects := $(subst .c,.o,$(sources))

.PHONY: replace

replace:
	@echo $(objects)

.PHONY: dollar

dollar:
	@echo $$