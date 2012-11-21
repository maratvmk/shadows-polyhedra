## Реберный список с вдвумя связами 
class Edge
	def initialize op={}
		set op
	end

	attr_accessor :b, :e, :l, :r, :b_next, :e_next

	def set op={}
		@b = op[:b] if op[:b]
		@e = op[:e] if op[:e]
		@l = op[:l] if op[:l]
		@r = op[:r] if op[:r]
		@b_next = op[:b_next] if op[:b_next]
		@e_next = op[:e_next] if op[:e_next]	
	end

	def == ed
		@b == ed.b && @e == ed.e
	end

	def != ed
		!(self == ed)		
	end

	## Противоположно направлены
	def =~ ed
		@b == ed.e && @e == ed.b
	end

	def change(b, e)
		@b = b; @e = e
	end

	def incident ed
		@b == ed.b || @b == ed.e || @e == ed.e || @e == ed.b
	end

	def inverse
		Edge.new(b: @e, e: @b)
	end

	def intersect ed, v
		ab =  v[@e] - v[@b]; cd = v[ed.e] - v[ed.b]
		if ab.x != 0
			k1 = ab.y/ab.x
			b1 = v[@b].y - k1 * v[@b].x
		else  
			x1 = v[@b].x
		end

		if cd.x != 0
			k2 = cd.y/cd.x 
			b2 = v[ed.b].y - k2 * v[ed.b].x
		else
			x2 = v[ed.b].x
		end

		if x1 or x2
			if x1 and x2
				return 'x1 == x2'  if x1 == x2
				return false
			end
			x = x1 if x1
			x = x2 if x2
		else
			return 'k1 == k2' if k1 == k2
			x = (b2 - b1)/(k1 - k2)
		end
		
		if (v[ed.b].x <= x and v[ed.e].x >= x) or (v[ed.b].x >= x and v[ed.e].x <= x)
			if (v[@b].x <= x and v[@e].x >= x) or (v[@b].x >= x and v[@e].x <= x)
				if k1
					Vec3f.new x, k1*x + b1, v[@b].z + ab.z * (x - v[@b].x)/ab.x
				else
					Vec3f.new x, k2*x + b2, v[ed.b].z + cd.z * (x - v[ed.b].x)/cd.x
				end
			else
				false
			end
		else
			false	
		end
	end

end