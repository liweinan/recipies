require_relative '../digraph'
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

  # dg = DirectedGraph.new
  # dg.read("example.in")
  # dg.vertexes.map { |vertex| puts vertex.dump }
  # puts '-' * 36
  # dg.edges.map { |edge| puts edge }
  # puts '-' * 36
  # dg.vertexesFrom.each_key do |key|
  #   puts "#{key} -> #{dg.vertexesFrom[key].map { |val| "#{val.key} " }}"
  # end
  # puts '-' * 36
  # puts dg.pv
  # puts '-' * 36
  # ddfs = DirectedDepthFirstSearch.new
  # ddfs.search(dg, dg.getVertex('0'))
  # puts ddfs.marked
  # puts '-' * 36
  # dc = DirectedCycle.new
  # dc.cycle(dg, dg.getVertex('5'))
  # dc.marked
  # puts '-' * 36
  # dc = DirectedCycle.new
  # dc.cycle(dg, dg.getVertex('0'))
  # dc.marked
  # puts '-' * 36
  # puts "3  -> 6? #{dg.connected?(dg.getVertex('3'), dg.getVertex('6'))}"
  # puts "1  -> 2? #{dg.connected?(dg.getVertex('1'), dg.getVertex('2'))}"
  # puts "2  -> 1? #{dg.connected?(dg.getVertex('2'), dg.getVertex('1'))}"
  # p dg.paths.each.map { |path| path.each.map { |vertex| "#{vertex} " } }
  # puts "1 <-> 2? #{dg.strongly_connected?(dg.getVertex('1'), dg.getVertex('2'))}"
  # puts "0  -> 5? #{dg.connected?(dg.getVertex('0'), dg.getVertex('5'))}"
  # puts "5  -> 0? #{dg.connected?(dg.getVertex('5'), dg.getVertex('0'))}"
  # p dg.paths.each.map { |path| path.each.map { |vertex| "#{vertex} " } }
  # puts "5 <-> 0? #{dg.strongly_connected?(dg.getVertex('5'), dg.getVertex('0'))}"
  # puts '-' * 36
  # puts dg.edgesTo.each.map { |toVertex, edges|
  #   "#{edges.each.map { |edge| edge.from.key }} -> #{toVertex}" }


  # it "should be adjacent" do
  #   @dg.adjacent?('7', '8').should be_true
  # end
  #
  # it "should not be adjacent" do
  #   @dg.adjacent?('0', '8').should be_false
  # end
  #
  # it "should have degree of four" do
  #   @dg.degree_of('9').should == 4
  # end
  #
  # it "should have max degree of four" do
  #   @dg.max_degree.should == [4, ["0", "9"]]
  # end
  #
  # it "should have number of self loops of 2" do
  #   @dg.number_of_self_loops == [{:from=>"1", :to=>"1"}, {:from=>"2", :to=>"2"}]
  # end
  #
  # it "should have correct adjacents" do
  #   @dg.adjacents == {"0"=>["5", "1", "2", "6"], "5"=>["0", "4", "3"], "4"=>["3", "6", "5"], "3"=>["4", "5"], "1"=>["0", "1"], "9"=>["12", "10", "11", "8"], "12"=>["9", "11"], "6"=>["4", "0"], "2"=>["0", "2"], "11"=>["12", "9"], "10"=>["9"], "7"=>["8"], "8"=>["7", "9"]}
  # end
end