def init(p, l, ind)
	d = l.size
	sz = p.size

	for i in 0..sz-1
		l << Edge.new(b: i + d, e: (i+1) % sz + d, length: p[i].dist(p[(i+1) % sz]), l: ind)
	end
end

def init_linear_nodal(pr)
	v, e, l, cr, p_border = [], [], [], [], []
	vrt_f = true

	for i in 0..pr.size-1 ## все вершины и ребра полигонов добавляем в лин.узловую модель
		p_border[i] = v.size..v.size + pr[i].size - 1
		v = (v + pr[i]).uniq{ |e| [e.x, e.y] }
		init(pr[i], l, i)
	end

	cr_beg = v.size
	l.sort!{ |a,b| a.length <=> b.length } ## отсортируем все ребра по длине

	while ed = l.pop ## обработанные ребра из l добавляем в e 
=begin
		for i in 0..v.size-1 ## ищем вершины принадлежащие ребру
			cr << v[i] if ed.b != i and ed.e != i and ed.contain(v[i], v) 
		end
		if cr.any? 
			vrt_f = true 
			puts 'wow'
		end
=end
		if cr.empty?
			for i in 0..e.size-1 ## ищем пересечение рёбер
				if !ed.incident(e[i]) and tmp = ed.intersect(e[i], v) 
					p e[i].l
					p_border[e[i].l] = p_border[ed.l] = nil

					v << tmp 
					cr << tmp

					e << Edge.new(b: e[i].b, e: v.size-1, l: e[i].l)
					e << Edge.new(b: v.size-1, e: e[i].e, l: e[i].l)
					e[i] = nil
				end
			end
			
			e.compact!
			v.uniq!{ |e| [e.x, e.y] }
		end

		if cr.any? 
			cr.sort!{ |a,b| v[ed.b].dist(a) <=> v[ed.b].dist(b) }
			for i in -1..cr.size-1
				(i != -1) ? b_ed = v.index(cr[i]) : b_ed = ed.b
				(i != cr.size-1) ? e_ed =  v.index(cr[i+1]) : e_ed = ed.e
				unless vrt_f
					e << Edge.new(b: b_ed, e: e_ed)
				else
					l << Edge.new(b: b_ed, e: e_ed, length: v[b_ed].dist(v[e_ed]), l: ed.l)
					l.sort!{ |a,b| a.length <=> b.length }
					vrt_f = false
				end
			end
			cr.clear
		else 
			e << ed
		end
	end
	
	p_border.compact!
	return [v, e, cr_beg..v.size-1, p_border]
end