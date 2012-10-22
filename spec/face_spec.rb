require_relative "../face.rb"
require_relative "../vec3f.rb"

describe 'Face class' do
	before :all do
		@f1 = Face.new(a:1, b:2, c:3, ab:1, bc:2, ca:3)	
		@f2 = Face.new(a:1, b:2, c:3)	
		@f3 = Face.new(a:1, b:2, c:4)		
		@f4 = Face.new(a:1, b:2, c:3)		
	end

	it 'check ==' do
		@f1.should == @f2
	end

	it 'check !=' do
		@f1.should_not == @f3
	end

	it 'check <' do
		@f1.should < @f3
	end

 	it 'check <=' do
 		@f1.should <= @f3
 		@f1.should <= @f4
 	end

	it 'check >' do
		@f3.should > @f1
	end

	it 'check >=' do
		@f3.should >= @f1
		@f4.should >= @f1
	end

	it 'check normal' do
		@vrt = []
		c = 1/Math.sqrt(3)
		@vrt[1] = Vec3f.new 1,0,0
		@vrt[2] = Vec3f.new 0,1,0
		@vrt[3] = Vec3f.new 0,0,1
		@f4.n(@vrt).should == Vec3f.new(c, c, c)
	end
end