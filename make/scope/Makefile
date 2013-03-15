define f1
	f1
endef

scope:
	@echo $(origin f1)
	@echo $(origin origin)
	@echo $(call f1)

letters := $(foreach letter,a b c d,$(addprefix 'P',$(letter)))

.PHONY: pl
pl:
	@echo $(letters)