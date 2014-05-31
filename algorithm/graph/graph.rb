# Self loop is allowed
# Repeated edges will be removed
class UndirectedGraph
  attr_accessor :vertexes, :edges, :adjacents

  class Edge
    attr_accessor :v, :w, :weight

    def initialize(v, w, weight)
      @v = v.to_i
      @w = w.to_i
      @weight = weight.to_i
    end

    def ==(other)
      # other == nil will cause recursive error
      if nil == other
        return false
      end

      eql = false
      eql = true if @v == other.v && @w == other.w
      eql = true if @v == other.w && @w == other.v
      eql
    end

    def <=>(other)
      self.weight <=> other.weight
    end

    def inspect
      "#{v} -> #{w}"
    end

    def to_s
      inspect
    end
  end

  def createEdge(v, w, weight=0)
    return nil if v == nil || w == nil
    Edge.new(v, w, weight)
  end

  def getEdge(v, w)
    __edge = createEdge(v, w)
    return nil if __edge == nil

    @edges.each do |edge|
      if edge == __edge
        return edge
      end
    end
    return nil
  end

  def initialize
    @vertexes = []
    @edges = []
    @adjacents = {}
  end

  def read(infile)
    File.open(infile, "r") do |f|
      while (line = f.gets)
        pair = line.split " "

        (0..1).each do |idx| # [0] -> v [1] -> w
          (@vertexes << pair[idx].to_i) unless @vertexes.include?(pair[idx].to_i)
        end

        edge = createEdge(pair[0], pair[1], pair[2])

        if edge != nil
          unless @edges.include?(edge)
            @edges << edge
          end

          (0..1).each do |idx|
            vertexes = @adjacents[pair[idx].to_i] # Adjacent vertexes
            (vertexes = []) if vertexes.nil?
            vertexes << pair[(idx+1)%2].to_i
            @adjacents[pair[idx].to_i] = vertexes.uniq
          end
        end
      end
    end

  end

  def pv()
    puts "graph G {"
    @edges.each do |edge|
      puts "#{edge.v} -- #{edge.w} [label = \"#{edge.weight}\"];"
    end
    puts "}"
  end

  def adjacent?(from, to)
    if @adjacents[from].include?(to)
      true
    else
      false
    end
  end

  def slow_adjacent?(from, to)
    if @edges.include?({:from => from, :to => to}) ||
        @edges.include?({:from => to, :to => from})
      true
    else
      false
    end
  end

  # The degree of a vertex is the number of edges incident on it.
  #
  # When an edge connects two vertices, we say that the vertices are
  # adjacent to one another and that the edge is incident on both vertices.
  def degree_of(from)
    @adjacents[from].length
  end

  def slow_degree_of(from)
    degree = 0
    @vertexes.each do |to|
      degree += 1 if adjacent?(from, to)
    end
    degree
  end

  def max_degree
    __max_degree = 0
    __vertexes = []
    @vertexes.each do |from|
      current_degree = 0
      @vertexes.each do |to|
        current_degree += 1 if adjacent?(from, to)
      end
      if (current_degree > __max_degree)
        __vertexes = []
        __vertexes << from
        __max_degree = current_degree
      elsif (current_degree == __max_degree)
        __vertexes << from
      end
    end
    [__max_degree, __vertexes]
  end

  def average_degree
    # each edge incident on two vertices
    2.0 * @edges.size / @vertexes.size
  end

  # self loop appears in adjacency list twice
  def number_of_self_loops
    self_loops = []
    number = 0
    @edges.each do |edge|
      if edge.v == edge.w
        self_loops << edge
        number += 1
      end
    end
    [number, self_loops]
  end
end

