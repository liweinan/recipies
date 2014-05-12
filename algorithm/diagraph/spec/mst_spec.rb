require_relative '../digraph'
require_relative '../mst'
require 'rspec'

describe MinimumSpanningTree do
  before do
    @dg = DirectedGraph.new
    @dg.read("example.in")
  end

  it "should generate MST correctly" do
    mst = MinimumSpanningTree.new(@dg)
  end
end

