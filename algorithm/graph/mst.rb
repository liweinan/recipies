class MinimumSpanningTree
  attr_accessor :crossing_edges, :marked, :graph, :mst

  def initialize(graph)
    @graph = graph
    @marked = []
    @mst = []
    @crossing_edges = PQueue.new
  end

  def lazy_prim
    visit(0)
    while (@crossing_edges.size != 0)
      edge = @crossing_edges.pop
      v, w = edge.v, edge.w
      next if (@marked.include?(v) && @marked.include?(w))
      @mst << edge
      visit(v) unless @marked.include?(v)
      visit(w) unless @marked.include?(w)
    end
  end

  def visit(vertex)
    @marked << vertex
    @graph.adjacents[vertex].each do |other|
      @crossing_edges << @graph.getEdge(vertex, other) unless @marked.include?(other)
    end
  end

  def colored_pv
    puts "graph G {"
    @graph.edges.each do |edge|
      color = @mst.include?(edge) ? "red" : "blue"
      puts "#{edge.v} -- #{edge.w} [color = \"#{color}\", label = \"#{edge.weight}\"];"
    end
    puts "}"
  end

end