# you can get the decimal byte number of a special character by prefixing it with ?
puts ?a
puts ?b
puts ?c

# represents the sequence you get by holding down the Alt (or Meta) key and hitting the 
# x key
puts ?\C-a
puts ?\M-z

# scans logged keystrokes for special characters
def snoop_on_keylog(input)
  input.each_byte do |b|
	case b
	  when ?\C-c; puts 'Control-C: stopped a process?'
	  when ?\C-z; puts 'Control-Z: suspended a process?'
	  when ?\n; puts 'Newline.'
	  when ?\M-x; puts 'Meta-x: using Emacs?'
	end
  end
end

snoop_on_keylog("ls -ltR\003emacsHello\012\370rot13-other-window\012\032")
# Control-C: stopped a process?
# Newline.
# Meta-x: using Emacs?
# Newline.
# Control-Z: suspended a process?

# Special characters are only interpreted in strings delimited by double quotes, or 
# strings created with %{} or %Q{}. They are not interpreted in strings delimited by 
# single quotes, or strings created with %q{}.

puts "foo\tbar"
# foo     bar
puts %{foo\tbar}
# foo     bar
puts %Q{foo\tbar}
# foo     bar

puts 'foo\tbar'
# foo\tbar
puts %q{foo\tbar}
# foo\tbar
