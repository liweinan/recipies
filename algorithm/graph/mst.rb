class MinimumSpanningTree
  attr_accessor :edges, :weight, :marked, :graph

  def initialize(graph)
    @graph = graph
    @marked = []
    greedy
  end

  #
  # Starting with a vertex with all adjacent edges colored gray, find a cut with no black edges,
  # color its minimum-weight edge black, and continue until V-1 edges have
  # been colored black.
  #
  def greedy
    @graph.vertexes.each do |vertex|
      if all_edges_of_vertex_grey?(vertex)
        @marked << minimal_edge_of(vertex)
      end
    end
  end

  def all_edges_of_vertex_grey?(vertex)
    edges = @graph.adjacents[vertex]
    return false if edges == nil
    all_grey = true
    edges.each do |edge|
      if @marked.include?(edge)
        all_grey = false
        break
      end
    end
    all_grey
  end

  def minimal_edge_of(vertex)
    adjacents = @graph.adjacents[vertex]
    return nil if adjacents == nil
    minimal = nil
    minweight = 100000
    adjacents.each do |adjacent|
      edge = {:from => vertex, :to => adjacent}
      weight = @graph.weights[edge]
      if weight.to_i < minweight
        minimal = edge
        minweight = weight.to_i
      end
    end

    if minweight < 10000
      minimal
    else
      nil
    end
  end
end