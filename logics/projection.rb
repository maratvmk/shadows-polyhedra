# плоскость в которую будем проектировать 
# задаем  через нормаль и точку лежащей на ней
# n = (A,B,C)
# r=r0+a*t
# Ax+By+Cz+D=0 => n*r+D=0 => t = -(D+n*r0)/(n*a)

def get_projection v, e, contour_cycles, n, p, lt, asm_point
	projection = Array.new(contour_cycles.size); m = 0
	asm = Array.new contour_cycles.size
	contour_cycles.each do |cycle|
		projection[m] = []; asm[m] = []
		cycle.each do |ed|
			point = v[e[ed].b]
			d = -(n*p)
			t = -(d + n*point)/(n*lt)
			pr = point + lt * t
			projection[m] << pr
			asm[m] << pr if asm_point.include? ed
		end
		m += 1
	end
	[projection, asm]
end