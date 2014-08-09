#!/usr/bin/ruby
arch = ARGV[0]
list = ""
File.open("el#{arch}.errata").each do |line|
  list += line.gsub(/^(.*)(\-\d+.*)/, '\1').gsub(/^(.*)(\-\d+.*)/, '\1')
end

File.open("el#{arch}.list", 'w') {|f| f.write(list.gsub(/\n/, ' ')) }
