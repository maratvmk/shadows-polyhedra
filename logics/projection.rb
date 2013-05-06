# плоскость в которую будем проектировать задаем  через нормаль и точку лежащей на ней
# n = (A,B,C) r=r0+a*t
# Ax+By+Cz+D=0 => n*r+D=0 => t = -(D+n*r0)/(n*a)

def project(v, e, cntrs, n, p, lt)
	m = -1
	pr = Array.new(cntrs.size)

	cntrs.each do |c|
		m += 1 
		pr[m] = []

		c.each do |ed|
			point = v[e[ed].b]
			t = (n*p - n*point)/(n*lt)
			pr[m] << point + lt * t
		end
	end
	return pr
end