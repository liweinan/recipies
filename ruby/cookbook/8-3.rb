def append_to_self(x)
   unless x.respond_to? :<<
      raise ArgumentError, "Method not supported"
   end
   if x.is_a? Numeric
      raise ArgumentError, "Numeric not supported"
   end
   x << x
end

puts append_to_self('abc')
puts append_to_self([1,2,3])
   
