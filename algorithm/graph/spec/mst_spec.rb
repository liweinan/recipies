require_relative '../graph'
require_relative '../mst'
require 'rspec'

describe MinimumSpanningTree do
  before do
    @ug = UndirectedGraph.new
    @ug.read("example.in")
  end

  it "should generate MST correctly" do
    mst = MinimumSpanningTree.new(@ug)
    p mst.marked
  end


end

