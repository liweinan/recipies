require './bowling.rb'

describe Bowling, "#score" do
	it "returns 0 for all gutter game" do
		bowling = Bowling.new
		20.times { bowling.hit(0) }
		bowling.score.should eq(0)
	end
end


