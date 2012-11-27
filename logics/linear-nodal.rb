def init p, l, ind
	offset = l.size; sz = p.size
	for i in 0..sz-1
		l << Edge.new(b: i + offset, e: (i+1) % sz + offset, length: (p[i] - p[(i+1) % sz]).length, l: ind)
	end
end

def init_linear_nodal pr
	v = []; e = []; l = []; cr = []
	for i in 0..pr.size-1 ## все вершины и ребра полигонов добавляем в лин.узловую модель
		v = (v + pr[i]).uniq{|e| [e.x, e.y]}
		init pr[i], l, i
	end
	cr_beg = v.size
	l.sort!{|a,b| a.length <=> b.length} ## отсортируем все ребра по длине

	while ed = l.pop
		for i in 0..e.size-1
			if !ed.incident(e[i]) and tmp = ed.intersect(e[i], v)
				v << tmp; cr << tmp
				e << Edge.new(b: e[i].b, e: v.size-1, l: e[i].l)
				e << Edge.new(b: v.size-1, e: e[i].e, l: e[i].l)
				e[i] = nil
			end
		end
		e.compact! #v.uniq!{|e| [e.x, e.y]}
		cr.sort!{|a,b| (v[ed.b] - a).length <=> (v[ed.b] - b).length}

		if cr.empty? 
			e << ed
		else 
			for i in 0..cr.size-2
				e << Edge.new(b: v.index(cr[i]), e: v.index(cr[i+1]))
			end
			e << Edge.new(b: ed.b, e: v.index(cr[0]))
			e << Edge.new(b: v.index(cr[-1]), e: ed.e)
			cr.clear
		end
	end
	cr_end = v.size-1
	[v, e, cr_beg..cr_end]
end