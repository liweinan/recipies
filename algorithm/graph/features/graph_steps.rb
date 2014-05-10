require_relative '../graph'

Given /^a graph instance$/ do
  @dg = UndirectedGraph.new
end

When /^I read in sample data$/ do
  @dg.read("example.in")
end

Then /^I should see sample data read in$/ do
  @dg.edges.should_not be_empty
end

Then /^I should see adjacent and non-adjacent vertexes$/ do
  @dg.adjacent?('7', '8').should be_true
  @dg.adjacent?('0', '8').should be_false
end

Then /^I should see degree_of method work$/ do
  @dg.degree_of('9').should == 4
end

Then /^I should see max_degree method work$/ do
  @dg.max_degree.should == [4, ["0", "9"]]
end

Then /^I should see self loop is correct$/ do
  @dg.number_of_self_loops == [{:from=>"1", :to=>"1"}, {:from=>"2", :to=>"2"}]
end
