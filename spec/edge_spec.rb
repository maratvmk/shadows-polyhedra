require_relative '../edge.rb'

describe 'edge class' do
	before :all do
		@e1 = Edge.new(b: 1, e: 23)
		@e2 = Edge.new(b: 23, e: 1)
		@e3 = Edge.new(b: 2, e: 10)
		@e4 = Edge.new(b: 1, e: 40)
		@e5 = Edge.new(b: 1, e: 23)
		@e6 = Edge.new(b: 4, e: 1)
	end

	describe 'compare operators' do
		it 'check ==' do
			@e1.should == @e2
		end

		it 'check !=' do
			@e1.should_not == @e3
		end

		it 'check =~' do
			@e1.should =~ @e2
		end

		it 'check <' do
			@e1.should < @e4
		end

		it 'check <=' do
			@e1.should <= @e5
			@e1.should <= @e4 
		end

		it 'check >' do
			@e4.should > @e1
		end

		it 'check >=' do
			@e5.should >= @e1
			@e4.should >= @e1
		end
	end

	describe 'other methods' do
		it 'check change method' do
			@e = Edge.new
			@e1.change 3,4
			@e1.b.should == 3
			@e1.e.should == 4
		end

		it 'check incedent method' do
			@e1.incident @e6
		end
	end
end