require_relative "vec3f.rb"

class Face
	def initialize op={}
		set op
	end

	attr_accessor :a, :b, :c, :ab, :bc, :ca, :n

	def set op
		@a = op[:a]  if op[:a]
		@b = op[:b]  if op[:b]
		@c = op[:c]  if op[:c]
		@ab = op[:ab]  if op[:ab]
		@bc = op[:bc]  if op[:bc]
		@ca = op[:ca]  if op[:ca]
	end

	def == f
		(@a == f.a && @b == f.b && @c == f.c) || (@ab == f.ab && @bc == f.bc && @ca == f.ca )
	end

	def < f
		@a < f.a || (@a == f.a && @b < f.b) || (@a == f.a && @b == f.b && @c < f.c)
	end

	def <= f
		self < f || self == f
	end

	def > f
		!(self <= f)
	end

	def >= f
		!(self < f)
	end

	def n vrt
		((vrt[@b] - vrt[@a]) ^ (vrt[@c] - vrt[@a])).normalize
	end
end