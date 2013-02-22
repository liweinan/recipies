'foobar'.each_byte { |x| puts "#{x} = #{x.chr}" }
'foobar'.scan( /./ ) { |c| puts c }
