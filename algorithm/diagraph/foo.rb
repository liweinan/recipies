class Foo
   attr_accessor :bar

   def <=>(that)
      self.bar <=> that.bar
   end
end

f1 = Foo.new
f2 = Foo.new
f1.bar = 0
f2.bar = 1
p f1 <=> f2
p f2 <=> f1
