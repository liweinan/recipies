code = <<END
blk = lambda {|idx| idx += 1}
END
puts RubyVM::InstructionSequence.compile(code).disasm


