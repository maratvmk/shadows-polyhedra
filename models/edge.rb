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
end