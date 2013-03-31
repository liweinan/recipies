# $(call assert,condition,message)
define assert
	$(if $1,$(error Assertion True),$(error Assertion failed: $2))
endef

# $(call assert-file-exists,wildcard-pattern)
define assert-file-exists
	$(call assert,$(wildcard $1),$1 does not exist)
endef

# $(call assert-not-null,make-variable)
define assert-not-null
	$(call assert,$($1),The variable "$1" is null)
endef

AAA='aaa'
error-exit:
	$(call assert-not-null,AAA)