compile: compile-summer

compile-summer: Summer.scala ChecksumAccumulator.scala
	fsc Summer.scala ChecksumAccumulator.scala

compile-rational: Rational.scala
	fsc Rational.scala

rational: compile-rational
	scala -classpath . Rational 1 2
	scala -classpath . Rational 2 4

longline: compile-longline
	scala -classpath . FindLongLines

compile-longline: FindLongLines.scala
	fsc FindLongLines.scala

summer: compile-summer
	scala -classpath . Summer is coming

greet: compile-greet
	scala -classpath . Greet

compile-greet:
	fsc greet.scala

apptraits: compile-apptraits
	scala -classpath . AppTraits

compile-apptraits:
	fsc apptraits.scala

traits: traits.scala
	scala traits.scala

clean:
	rm *.class

.PHONY: rational summer clean
