# Self loop is allowed
# Repeated edges will be removed
class UndirectedGraph
  attr_accessor :vertexes, :edges, :adjacents

  def read(infile)
    @vertexes = []
    @edges = []
    @adjacents = {}
    File.open(infile, "r") do |f|
      while (line = f.gets)
        pair = line.split " "

        (0..1).each do |idx| # [0] -> from [1] -> to
          (@vertexes << pair[idx]) unless @vertexes.include?(pair[idx])
        end

        edge = {:from => pair[0], :to => pair[1]}
        if (pair[0] != nil && pair[1] != nil) &&
            !@edges.include?(edge) &&
            !@edges.include?({:from => pair[1], :to => pair[0]}) # Undirected
          (@edges << edge)
        end

        (0..1).each do |idx|
          vertexes = @adjacents[pair[idx]] # Adjacent vertexes
          (vertexes = []) if vertexes.nil?
          vertexes << pair[(idx+1)%2]
          @adjacents[pair[idx]] = vertexes.uniq
        end
      end
    end
  end

  def pv
    puts "graph G {"
    @edges.each do |edge|
      puts "#{edge[:from]} -- #{edge[:to]};"
    end
    puts "}"
  end

  def adjacent?(from, to)
    if @adjacents[from].include?(to)
      true
    else
      false
    end
  end

  def slow_adjacent?(from, to)
    if @edges.include?({:from => from, :to => to}) ||
        @edges.include?({:from => to, :to => from})
      true
    else
      false
    end
  end

  # The degree of a vertex is the number of edges incident on it.
  #
  # When an edge connects two vertices, we say that the vertices are
  # adjacent to one another and that the edge is incident on both vertices.
  def degree_of(from)
    @adjacents[from].length
  end

  def slow_degree_of(from)
    degree = 0
    @vertexes.each do |to|
      degree += 1 if adjacent?(from, to)
    end
    degree
  end

  def max_degree
    __max_degree = 0
    __vertexes = []
    @vertexes.each do |from|
      current_degree = 0
      @vertexes.each do |to|
        current_degree += 1 if adjacent?(from, to)
      end
      if (current_degree > __max_degree)
        __vertexes = []
        __vertexes << from
        __max_degree = current_degree
      elsif (current_degree == __max_degree)
        __vertexes << from
      end
    end
    [__max_degree, __vertexes]
  end

  def average_degree
    # each edge incident on two vertices
    2.0 * @edges.size / @vertexes.size
  end

  # self loop appears in adjacency list twice
  def number_of_self_loops
    self_loops = []
    number = 0
    @edges.each do |edge|
      if edge[:from] == edge[:to]
        self_loops << edge
        number += 1
      end
    end
    [number, self_loops]
  end
end

#p ud.edges
#ud.pv
#puts "adjacent?(7, 8) -> #{ud.adjacent?('7', '8')}"
#puts "adjacent?(0, 8) -> #{ud.adjacent?('0', '8')}"
#puts "degree_of(9) -> #{ud.degree_of('9')}"
#puts "max_degree -> #{ud.max_degree}"
#puts "average_degree -> #{ud.average_degree}"
#puts "number_of_self_loops -> #{ud.number_of_self_loops}"
#puts "adjacents-> #{ud.adjacents}"

require 'rspec'

describe UndirectedGraph do
  before do
    @ud = UndirectedGraph.new
    @ud.read("example.in")
  end

  it "should be adjacent" do
    @ud.adjacent?('7', '8').should be_true
  end

  it "should not be adjacent" do
    @ud.adjacent?('0', '8').should be_false
  end

  it "should have degree of four" do
    @ud.degree_of('9').should == 4
  end

  it "should have max degress of four" do
    @ud.max_degree.should == [4, ["0", "9"]]
  end

  it "should have number of self loops of 2" do
    @ud.number_of_self_loops == [{:from=>"1", :to=>"1"}, {:from=>"2", :to=>"2"}]
  end

  it "should have correct adjacents" do
    @ud.adjacents == {"0"=>["5", "1", "2", "6"], "5"=>["0", "4", "3"], "4"=>["3", "6", "5"], "3"=>["4", "5"], "1"=>["0", "1"], "9"=>["12", "10", "11", "8"], "12"=>["9", "11"], "6"=>["4", "0"], "2"=>["0", "2"], "11"=>["12", "9"], "10"=>["9"], "7"=>["8"], "8"=>["7", "9"]}
  end
end