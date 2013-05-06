class Vec3f
	def initialize(x = 0.0, y = 0.0, z = 0.0)
		@x, @y, @z = x, y, z
	end

	attr_accessor :x, :y, :z

	def == f
		@x == f.x && @y == f.y &&  @z == f.z
	end

	def + f
		Vec3f.new(@x + f.x, @y + f.y, @z + f.z)
	end

	def - f
		Vec3f.new(@x - f.x, @y - f.y, @z - f.z)
	end

	def * f
		if f.class == Vec3f
			@x*f.x + @y*f.y + @z*f.z
		else
			Vec3f.new(@x*f, @y*f, @z*f)
		end
	end

	def length
		Math.sqrt(@x**2 + @y**2 + @z**2)
	end

	def normalize
		l = 1/length
		@x *= l; @y *= l; @z *= l
		self
	end

	## Векторное произведение
	def ^ f
		Vec3f.new(@y*f.z - f.y*@z, @z*f.x - f.z*@x, @x*f.y - f.x*@y)
	end

	def dist(f)
		(self - f).length
	end
end