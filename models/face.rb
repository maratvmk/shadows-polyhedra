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

	def [] i
		case i
			when 0 then @ab
			when 1 then @bc
			when 2 then @ca
		end
	end

	def norm vrt
		return @n if @n
		a = vrt[@a].clone; b = vrt[@b].clone; c = vrt[@c].clone
		@n ||= ((b - a) ^ (c - a)).normalize
	end

	def facial v
		@n * v < 0
	end
end