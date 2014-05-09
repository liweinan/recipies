class DirectedGraph
  attr_accessor :adjacents, :vertexes, :edges

  class Vertex
    attr_accessor :out_degree, :in_degree
    attr_accessor :key

    def initialize(key)
      @key = key
      @out_degree = 0
      @in_degree = 0
    end

    def ==(other)
      @key == other.key
    end

    def dump
      "#{key}: in->#{@in_degree} out->#{@out_degree}"
    end

    def to_s
      @key
    end
  end

  class Edge
    attr_accessor :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def ==(other)
      @from == other.from && @to == other.to
    end

    def to_s
      "#{@from} -> #{@to}"
    end
  end

  def read(infile)
    @vertexes = []
    @edges = []
    @adjacents = {}
    File.open(infile, "r") do |f|
      while (line = f.gets)
        pair = line.split " "
        (0..1).each do |idx|
          (@vertexes << Vertex.new(pair[idx])) unless @vertexes.include?(Vertex.new(pair[idx]))
        end

        edge = Edge.new(Vertex.new(pair[0]), Vertex.new(pair[1]))
        if pair[0] != nil && pair[1] != nil && !@edges.include?(edge)
          (@edges << edge)
          getVertex(edge.from).out_degree += 1
          getVertex(edge.to).in_degree += 1

          @adjacents[edge.from.key] = [] if @adjacents[edge.from.key] == nil
          @adjacents[edge.from.key] << edge.to
        end
      end
    end

  end

  def getVertex(val)
    if val.class == Vertex
      val = val.key
    end
    @vertexes.each do |vertex|
      if vertex.key == val
        return vertex
      end
    end
    nil
  end

  def pv
    puts "digraph G {"
    @edges.each do |edge|
      puts "#{edge.from} -> #{edge.to};"
    end
    puts "}"
  end

  def connected?(from, to)
    @__flags = []
    @__marked = []
    __connected?(from, to)
    @__flags.flatten.include?(true)
  end

  def strongly_connected?(from, to)
    connected?(from, to) && connected?(to, from)
  end

  private
  def __connected?(from, to)
    @__marked << from
    if from == to
      (@__flags << true)
      return
    end

    @adjacents[from.key].each do |adjacent|
      next if (adjacent == from || @__marked.include?(adjacent))
      if adjacent == to
        @__flags << true
        return
      end
      __connected?(adjacent, to)
    end
    @__flags << false
  end
end

class DirectedDepthFirstSearch
  attr_accessor :marked

  def initialize
    @marked = []
  end

  def search(diagraph, vertex)
    @marked << vertex
    diagraph.adjacents[vertex.key] ||= []
    diagraph.adjacents[vertex.key].each do |adjacent|
      search(diagraph, adjacent) unless @marked.include?(adjacent)
    end
  end
end

class DirectedCycle
  attr_accessor :marked, :has_cycle

  def initialize
    @marked = []
    @has_cycle = false
  end

  def has_cycle?
    @has_cycle
  end

  def cycle(diagraph, vertex)
    return @marked if has_cycle?
    @marked << vertex
    puts "vertex: #{vertex}"
    diagraph.adjacents[vertex.key] ||= []
    diagraph.adjacents[vertex.key].each do |adjacent|
      puts "adjacent: #{adjacent}"
      if @marked.include?(adjacent)
        @has_cycle = true
        @marked = @marked[(@marked.index(adjacent))..(@marked.length-1)]
        puts "marked: #{@marked.each.map { |marked| marked.key }}"
        return @marked
      else
        cycle(diagraph, adjacent)
        return @marked if has_cycle?
      end
      puts "pop: #{@marked.pop}"
    end
    @marked
  end
end


dg = DirectedGraph.new
dg.read("example.in")
dg.vertexes.map { |vertex| puts vertex.dump }
puts '-' * 36
dg.edges.map { |edge| puts edge }
puts '-' * 36
dg.adjacents.each_key do |key|
  puts "#{key} -> #{dg.adjacents[key].map { |val| "#{val.key} " }}"
end
puts '-' * 36
puts dg.pv
puts '-' * 36
ddfs = DirectedDepthFirstSearch.new
ddfs.search(dg, dg.getVertex('0'))
puts ddfs.marked
puts '-' * 36
dc = DirectedCycle.new
dc.cycle(dg, dg.getVertex('5'))
dc.marked
puts '-' * 36
dc = DirectedCycle.new
dc.cycle(dg, dg.getVertex('0'))
dc.marked
puts '-' * 36
puts "0  -> 5? #{dg.connected?(dg.getVertex('0'), dg.getVertex('5'))}"
puts "5  -> 0? #{dg.connected?(dg.getVertex('5'), dg.getVertex('0'))}"
puts "1  -> 2? #{dg.connected?(dg.getVertex('1'), dg.getVertex('2'))}"
puts "3  -> 6? #{dg.connected?(dg.getVertex('3'), dg.getVertex('6'))}"
puts "0  -> 4? #{dg.connected?(dg.getVertex('0'), dg.getVertex('4'))}"
puts "0 <-  4? #{dg.connected?(dg.getVertex('4'), dg.getVertex('0'))}"
puts "1 <-> 1? #{dg.strongly_connected?(dg.getVertex('1'), dg.getVertex('1'))}"
puts "4 <-> 5? #{dg.strongly_connected?(dg.getVertex('4'), dg.getVertex('5'))}"
puts "0 <-> 4? #{dg.strongly_connected?(dg.getVertex('4'), dg.getVertex('0'))}"
