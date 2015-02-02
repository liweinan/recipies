# convert ulysses markdown to bbcode
class Main
  $code_buffer = []
  $quote_buffer = []
  $is_code_sec = false
  $is_quote_sec = false

  def flush_buffer(buf, flag, close_tag)
    eval "$#{buf}.each { |line| puts line }"
    puts close_tag
    eval "$#{buf} = []"
    eval "$#{flag} = false"
  end

  def convert
    File.open('xxx.txt').each do |line|
      if line[0] == '#'
        if line[1] == '#'
          puts line.gsub(/^#*\s*(.*)\s*/, '[size=large]\1[/size]')
          puts
        else
          puts line.gsub(/^#*\s*(.*)\s*/, '[size=xx-large]\1[/size]')
          puts
        end
        next
      elsif line[0] == "'" && line[1] == "'"
        if $is_code_sec == false
          $code_buffer << '[code]'
          $is_code_sec = true
        end

        $code_buffer << line.gsub(/'' (.*)\s*/, '\1')
        next
      elsif line[0] == '>'
        if $is_quote_sec == false
          $quote_buffer << '[quote]'
          $is_quote_sec = true
        end

        $quote_buffer << line.gsub(/> (.*)\s*/, '\1')
        next
      else
        if $is_code_sec == true
          flush_buffer('code_buffer', 'is_code_sec', '[/code]')
        elsif $is_quote_sec == true
          flush_buffer('quote_buffer', 'is_quote_sec', '[/quote]')
        end
        puts line
        next
      end
    end
  end
end

main = Main.new
main.convert

