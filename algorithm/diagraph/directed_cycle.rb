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
