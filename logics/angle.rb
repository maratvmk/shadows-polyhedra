def angle v, lt, n
	v = v.map{ |p| p - lt* (n * p)/(n * lt) } ## проекция
	a = v[0] - v[1]; b = v[2] - v[1]
	grad = Math.acos (a * b)/(a.length * b.length) 
	grad * 180/Math::PI 
end