# плоскость в которую будем проектировать 
# задаем  через нормаль и точку лежащей на ней
# n = (A,B,C)
# r=r0+a*t
# Ax+By+Cz+D=0 => n*r+D=0 => t = -(D+n*r0)/(n*a)

def project v, e, contours, n, p, lt
	pr = Array.new(contours.size); m = 0
	contours.each do |cntr|
		pr[m] = []
		cntr.each do |ed|
			point = v[e[ed].b]
			d = -(n*p)
			t = -(d + n*point)/(n*lt)
			pr[m] << point + lt * t
		end
		m += 1
	end
	pr
end