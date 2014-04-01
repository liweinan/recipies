class MinimumSpanningTree
  attr_accessor :edges, :weight, :marked, :graph

  def initialize(graph)
    @graph = graph
    @marked = []
  end

end