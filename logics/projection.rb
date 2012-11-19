# плоскость в которую будем проектировать 
# задаем  через нормаль и точку лежащей на ней
# n = (A,B,C)
# r=r0+a*t
# Ax+By+Cz+D=0 => n*r+D=0 => t = -(D+n*r0)/(n*a)

def get_projection v, e, contour_cycles, n, p, lt
	projection = Array.new(contour_cycles.size); m = 0
	contour_cycles.each do |cycle|
		projection[m] = []
		cycle.each do |ed|
			point = v[e[ed].b]
			d = -(n*p)
			t = -(d + n*point)/(n*lt)
			projection[m] << point + lt * t
		end
		m += 1
	end
	projection
end