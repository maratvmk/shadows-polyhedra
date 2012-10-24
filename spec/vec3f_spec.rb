require_relative '../vec3f.rb'

describe 'Vec3f class' do
	before :each do
		@v1 = Vec3f.new(1, 2, 2)
	end

	before :all do
		@v2 = Vec3f.new(1, 2, 2)
		@v3 = Vec3f.new(2, 4, 4)
		@v4 = Vec3f.new(5, 8, 9)
		@v5 = Vec3f.new(-4, -6, -7)
		@v6 = Vec3f.new(5, 10, 10)
		@v7 = Vec3f.new(1/4.0, 1/2.0, 1/2.0)
		@v8 = Vec3f.new(1/3.0, 2/3.0, 2/3.0)
		@v9 = Vec3f.new(4, 2, -4)
		@v10 = Vec3f.new(2, 2, 2)
		@v11 = Vec3f.new(1, 3, 2)
		@v12 = Vec3f.new(1, 2, 3)
	end

	describe 'operators' do
		it 'check - unary' do
			(-@v1).should == Vec3f.new(-1, -2, -2) 
		end

		it 'check ==' do
			@v1.should == @v2
		end 

		it 'check +=' do
			@v1 += @v2
			@v1.should == @v3
		end

		it 'check -=' do
			@v1 -= @v4
			@v1.should == @v5
		end

		it 'check *=' do
			@v1 *= 5 
			@v1.should == @v6
		end

		it 'check /=' do
			@v1 /= 4.0
			@v1.should == @v7
		end

 		it 'vector product ^' do
 			@v = @v3 ^ @v4
 			@v.should == @v9
 		end

 		it 'check <' do
 			@v1.should < @v10
 			@v1.should < @v11
 			@v1.should < @v12
 		end

 		it 'check scalar product' do
 			(@v1*@v3).should == 18
 		end
 	end

 	describe 'method' do
 		it 'length' do
 			@v1.length.should == 3
 		end

 		it 'normalize' do
 			@v1.normalize
 			@v1.should == @v8
 		end

 		it 'distance' do
 			@v1.distance(@v4).should == Math.sqrt(101)
 		end

 	end
end