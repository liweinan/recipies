class Duck
  def quack
	'Quack!'
  end

  def swim
	'Paddle paddle paddle...'
  end
end

class Goose
  def honk
	'Honk!'
  end
  def swim
	'Splash splash splash...'
  end
end

class DuckRecording
  def quack
	play
  end

  def play
	'Quack!'
  end
end

def make_it_quack(duck)
  duck.quack
end

puts make_it_quack(Duck.new)                      # => "Quack!"
puts make_it_quack(DuckRecording.new)             # => "Quack!"

def make_it_swim(duck)
  duck.swim
end

puts make_it_swim(Duck.new)                       # => "Paddle paddle paddle…"
puts make_it_swim(Goose.new)                      # => "Splash splash splash…"
