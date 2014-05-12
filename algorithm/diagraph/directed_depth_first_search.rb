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