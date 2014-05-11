class DirectedGraph
  attr_accessor :vertexesFrom, :vertexes, :edges, :edgesTo, :edgesFrom, :paths

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
    attr_accessor :from, :to, :weight

    def initialize(from, to, weight = 1)
      @from = from
      @to = to
      @weight = weight
      @__either = @from
    end

    def ==(other)
      @from == other.from && @to == other.to
    end

    def to_s
      "#{@from} -> #{@to}"
    end

    def either
      @__either = (@__either == @from ? @to : @from)
      @__either
    end

    def other(vertex)
      vertex == @from ? @to : @from
    end

    def <=>(other)
      self.weight <=> other.weight
    end
  end

  def read(infile)
    @vertexes = []
    @edges = []
    @vertexesFrom = {}
    @edgesTo = {}
    @edgesFrom = {}
    File.open(infile, "r") do |f|
      while (line = f.gets)
        pair = line.split " "
        (0..1).each do |idx|
          if pair[idx] != nil
            (@vertexes << Vertex.new(pair[idx])) unless @vertexes.include?(Vertex.new(pair[idx]))
          end
        end

        edge = Edge.new(Vertex.new(pair[0]), Vertex.new(pair[1]))
        if pair[0] != nil && pair[1] != nil && !@edges.include?(edge)
          (@edges << edge)
          getVertex(edge.from).out_degree += 1
          getVertex(edge.to).in_degree += 1

          @edgesTo[edge.to.key] = [] if @edgesTo[edge.to.key] == nil
          @edgesTo[edge.to.key] << edge

          @edgesFrom[edge.from.key] = [] if @edgesFrom[edge.from.key] == nil
          @edgesFrom[edge.from.key] << edge

          @vertexesFrom[edge.from.key] = [] if @vertexesFrom[edge.from.key] == nil
          @vertexesFrom[edge.from.key] << edge.to
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

  def getEdge(from, to)
    that = Edge.new(from, to)
    @edges.each do |this|
      return this if this == that
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
    @paths = []
    @__path = []
    __connected?(from, to)
    @__flags.include?(true)
  end

  def strongly_connected?(from, to)
    connected?(from, to) && connected?(to, from)
  end

  private
  def __connected?(from, to)
    @__marked << from
    @__path << from
    if from == to
      (@__flags << true)
      return
    end
    @vertexesFrom[from.key] ||= []
    @vertexesFrom[from.key].each do |vertexFrom|
      next if (vertexFrom == from || @__marked.include?(vertexFrom))
      if vertexFrom == to
        @__flags << true
        @paths << @__path
        @__path = []
        return
      end
      __connected?(vertexFrom, to)
    end
    @__flags << false
    @__path.pop
  end
end

class DirectedDepthFirstSearch
  attr_accessor :marked

  def initialize
    @marked = []
  end

  def search(diagraph, vertex)
    @marked << vertex
    diagraph.vertexesFrom[vertex.key] ||= []
    diagraph.vertexesFrom[vertex.key].each do |vertexFrom|
      search(diagraph, vertexFrom) unless @marked.include?(vertexFrom)
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
    return if has_cycle?
    @marked << vertex
    diagraph.vertexesFrom[vertex.key] ||= []
    diagraph.vertexesFrom[vertex.key].each do |vertexFrom|
      if @marked.include?(vertexFrom)
        @has_cycle = true
        @marked = @marked[(@marked.index(vertexFrom))..(@marked.length-1)]
        return
      else
        cycle(diagraph, vertexFrom)
        return if has_cycle?
      end
    end
    @marked.pop
  end
end
