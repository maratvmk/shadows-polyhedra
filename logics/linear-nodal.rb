def init p, l
	offset = l.size
	for i in 0..p.size-1
		l << Edge.new(b: i + offset, e: (i+1) % p.size + offset, length: (p[i] - p[(i+1) % p.size]).length)
	end
end

def init_linear_nodal p1, p2
	e = []; l = []; cr = []

	v = (p1 + p2).uniq{|e| [e.x, e.y]}
	init p1, l; init p2, l
	l.sort!{|a,b| a.length <=> b.length}

	while ed = l.pop
		for i in 0..e.size-1
			if !ed.incident(e[i]) and tmp = ed.intersect(e[i], v)
				v << tmp; cr << tmp
				e << Edge.new(b: e[i].b, e: v.size-1)
				e << Edge.new(b: v.size-1, e: e[i].e)
				e[i] = nil
			end
		end
		e.compact! #v.uniq!{|e| [e.x, e.y]}
		cr.sort!{|a,b| (v[ed.b] - a).length <=> (v[ed.b] - b).length}
		
		for i in 0..cr.size-2
			e << Edge.new(b: v.index(cr[i]), e: v.index(cr[i+1]))
		end

		if cr.empty? 
			e << ed
		else 
			e << Edge.new(b: ed.b, e: v.index(cr[0]))
			e << Edge.new(b: v.index(cr[-1]), e: ed.e)
			cr.clear
		end
	end
	[v, e]
end

