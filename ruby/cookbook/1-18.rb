class String
  def mgsub(key_value_pairs=[].freeze)
	regexp_fragments = key_value_pairs.collect { |k,v| k }
	puts regexp_fragments
	puts Regexp.union(*regexp_fragments)
	gsub(Regexp.union(*regexp_fragments)) do |match|
	  puts match
	  key_value_pairs.detect{|k,v| k =~ match}[1]
	end
  end
end

puts  "GO HOME!".mgsub([[/.*GO/i, 'Home'], [/home/i, 'is where the heart is']])
