define free-space
	df
endef

define parent
	echo "parent has two params: $1, $2"
	$(call child,$1)
endef

define child
	echo "child has one param: $1"
	echo "but child can also see parent's second param: $2!"
endef

.PHONY: scoping_issue default

scoping_issue:
	@$(call parent,one,two)

default:
	$(free-space)

wildcard:
	@echo $(wildcard M*)