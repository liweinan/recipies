.PHONY: dummy

dummy:
	echo $(MAKE_VERSION)
	echo $(CURDIR)
	@echo "$(.VARIABLES)" > /dev/null
	echo $(COMPILE.C)
	echo $(CXX)
	echo $(CXXFLAGS)
	echo $(TARGET_ARCH)

default: pre pre2 pre2
	@echo $+
	@echo $<
	@echo $^
	@echo $@
	@echo $?

x = apple
y = pear
z = orange

fruits:
	echo $(x) $(y) $(z)

.PHONY: fruits
