class Dna
  attr_accessor :alphabet, :bindata

  MAP = {'A' => 0, 'T' => 1, 'G' => 2, 'C' => 3}

  def initialize(alphabet)
    @alphabet = alphabet
  end

  def compress
    @bindata = @alphabet.split('').map { |alpha| MAP[alpha] }.pack('c*')
  end

end

dna = Dna.new("ATTGC")
dna.compress
p dna.bindata # "\x00\x01\x01\x02\x03"
