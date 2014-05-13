require_relative '../graph'
require 'rspec'

describe UndirectedGraph do
  before do
    @dg = UndirectedGraph.new
    @dg.read("example.in")
  end

  it "should be adjacent" do
    @dg.adjacent?(7, 8).should be_true
  end

  it "should not be adjacent" do
    @dg.adjacent?(0, 8).should be_false
  end

  it "should have correct degrees" do
    @dg.degree_of(9).should == 5
  end

  it "should have max degree of four" do
    @dg.max_degree.should == [5, [0, 9]]
  end

  it "should have number of self loops of 2" do
    @dg.number_of_self_loops == [2, [@dg.createEdge(1, 1), @dg.createEdge(2, 2)]]
  end

  it "should have correct adjacents" do
    p @dg.adjacents
    @dg.adjacents == {0 => [5, 1, 2, 6], 5 => [0, 4, 3], 4 => [3, 6, 5], 3 => [4, 5], 1 => [0, 1], 9 => [12, 10, 11, 8], 12 => [9, 11], 6 => [4, 0], 2 => [0, 2], 11 => [12, 9], 10 => [9], 7 => [8], 8 => [7, 9]}
  end

  it "should have weights" do
    @dg.weights.should_not be_nil
  end
end