# плоскость в которую будем проектировать 
# задаем  через нормаль и точку лежащей на ней
# n = (A,B,C)
# r=r0+a*t
# Ax+By+Cz+D=0 => n*r+D=0 => t = -(D+n*r0)/(n*a)

def project v, e, contours, n, p, lt, asm_points
	pr = Array.new(contours.size); m = 0
	asm_prs = Array.new contours.size
	contours.each do |cntr|
		pr[m] = []; asm_prs[m] = []
		cntr.each do |ed|
			point = v[e[ed].b]
			d = -(n*p)
			t = -(d + n*point)/(n*lt)
			pp = point + lt * t
			pr[m] << pp
			asm_prs[m] << pp if asm_points.include? ed
		end
		m += 1
	end
	[pr, asm_prs]
end