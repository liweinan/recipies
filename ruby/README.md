	>> [1,2] + [3,4]
	=> [1, 2, 3, 4]
	>> [1,2] + [3,4] + [5,6]
	=> [1, 2, 3, 4, 5, 6]
	>> s = "Some text."
	=> "Some text."
	>> s.center(15)
	=> "  Some text.   "
	>> s.center(30)
	=> "          Some text.          "
	>> s.
	?> ljust(15)
	=> "Some text.     "
	>> s.
	?> rjust(15)
	=> "     Some text."
	>>  str="abc"
	=> "abc"
	>> str.succ
	=> "abd"

---

	>> str.gsub(/.{1,2}/,'X')
	=> "XX"
	>> str.gsub(/.{1,}/,'X')
	=> "X"
	>> str.gsub(/.{1}/,'X')
	=> "XXX"
	>> str.gsub(/.{3}/,'X')
	=> "X"
	>> str.gsub(/./,'X')
	=> "XXX"
	>> str
	=> "abc"
	>> str.gsub(/(.{1})/,\1)
	SyntaxError: compile error
	(irb):26: syntax error, unexpected $undefined
	str.gsub(/(.{1})/,\1)
	                   ^
		from (irb):26
	>> str.gsub(/(.{1})/,"\\1")
	=> "abc"
	>> str.gsub(/(.{1,})/,"\\1")
	=> "abc"
	>> str.gsub(/(.{1,2})/,"\\1")
	=> "abc"
	>> str.gsub(/(.{1,2})/,"a")
	=> "aa"
	>> str.gsub(/(.{1,2})(.*)/,"\\2")
	=> "c"

---

	>> str = "abc\rdef\nggg"
	=> "abc\rdef\nggg"
	>> puts str
	def
	ggg
	=> nil
	>> str =~ /a.*d.*g$/
	=> nil
	>> str =~ /a.*d.*g$/m
	=> 0
	>>