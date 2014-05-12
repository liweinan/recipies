require_relative '../digraph'
require_relative '../directed_cycle'
require_relative '../directed_depth_first_search'
require 'rspec'

describe DirectedGraph do
  before do
    @dg = DirectedGraph.new
    @dg.read("example.in")
  end

  it "should have these vertexes" do
    @dg.vertexes.each.map { |vertex| vertex.key }.should =~ (0..12).each.map { |idx| idx.to_s }
  end

  it "should have these edges" do
    expected_edges = ["0 -> 5", "4 -> 3", "0 -> 1", "9 -> 12", "5 -> 4",
                      "0 -> 2", "12 -> 11", "9 -> 10", "8 -> 7", "7 -> 0",
                      "9 -> 11", "5 -> 3", "9 -> 8", "2 -> 4", "4 -> 6",
                      "6 -> 12", "2 -> 12", "11 -> 8"]

    expected_edges.should =~ @dg.edges.each.map { |edge| "#{edge.from} -> #{edge.to}" }
  end

  it "should_have_expected_edges" do
    from = @dg.getVertex("0")
    to = @dg.getVertex("5")
    edge = @dg.getEdge(from, to)
    edge.should_not be_nil
    edge.from.should == from
    edge.to.should == to

    edge.either.should == to
    edge.either.should == from

    edge.other(to).should == from

    from2 = @dg.getVertex("4")
    to2 = @dg.getVertex("3")
    edge2 = @dg.getEdge(from2, to2)
    edge2.should_not be_nil

    (edge <=> edge2).should == 0
    edge2.weight = 2
    (edge <=> edge2).should < 0
    edge2.weight = 0
    (edge <=> edge2).should > 0
  end

  it "should_have_cycle" do
    dc = DirectedCycle.new
    dc.cycle(@dg, @dg.getVertex('0'))
    dc.has_cycle?.should be_true
    (dc.marked.each.map { |vertex| vertex.key }).should == ["0", "5", "4", "6", "12", "11", "8", "7"]
  end

  it "should support DirectedDepthFirstSearch" do
    ddfs = DirectedDepthFirstSearch.new
    ddfs.search(@dg, @dg.getVertex('0'))

    (ddfs.marked.each.map { |vertex| vertex.key }).should =~ ("0".."12").to_a - ["9", "10"]
  end

  it "should have connected vertexes" do
    @dg.connected?(@dg.getVertex('3'), @dg.getVertex('6')).should be_false
    @dg.connected?(@dg.getVertex('6'), @dg.getVertex('3')).should be_true
    @dg.strongly_connected?(@dg.getVertex('6'), @dg.getVertex('3')).should be_false
    @dg.strongly_connected?(@dg.getVertex('0'), @dg.getVertex('12')).should be_true
  end
end