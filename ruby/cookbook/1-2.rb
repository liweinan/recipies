#!/usr/bin/env ruby
number = 5
puts "The number is #{number}."                      # => "The number is 5."
puts "The number is #{5}."                           # => "The number is 5."
puts "The number after #{number} is #{number.next}."
# => "The number after 5 is 6."
puts "The number prior to #{number} is #{number-1}."
# => "The number prior to 5 is 4."
puts "We're ##{number}!"                             # => "We're #5!"

str=%{Here is #{class InstantClass
   def bar
	  "some text"
	end
 end
 InstantClass.new.bar
}.}
# => "Here is some text."

puts str

puts "I've set x to #{x = 5; x += 1}."      # => "I've set x to 6."
puts x                                      # => 6

name = "Mr. Lorum"
email = <<END
Dear #{name},

Unfortunately we cannot process your insurance claim at this
time. This is because we are a bakery, not an insurance company.

Signed,
 Nil, Null, and None
 Bakers to Her Majesty the Singleton
END

puts email



