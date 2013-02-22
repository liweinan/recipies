puts :AnotherSymbol.id2name

puts :dodecahedron.object_id               # => 4565262
puts symbol_name = "dodecahedron"
puts symbol_name.intern                    # => :dodecahedron
puts symbol_name.intern.object_id          # => 4565262

puts "string".object_id
puts "string".object_id
puts :symbol.object_id
puts :symbol.object_id
