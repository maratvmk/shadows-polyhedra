require_relative "../models/vec3f.rb"
require_relative "../models/edge.rb"

a = Vec3f.new 0.0, 0.0, 0.0
b = Vec3f.new 3.0, 0.0, 0.0
c = Vec3f.new 2.0, 4.0, 0.0

d = Vec3f.new 1.0, 3.0, 0.0
e = Vec3f.new 4.0, -4.0, 0.0
f = Vec3f.new 5.0, 3.0, 0.0

p1 = [a, b, c]
p2 = [d, e, f]

e = []; @l = []; cr = []
v = (p1 + p2).uniq{|e| [e.x, e.y]}

def init p
	offset = @l.size
	for i in 0..p.size-1
		@l << Edge.new(b: i + offset, e: (i+1) % p.size + offset, length: (p[i] - p[(i+1) % p.size]).length)
	end
end

def right m_ed, e
	tmp = m_ed[0]
	for i in 0..m_ed.size-2
		if e[m_ed[i]].right e[m_ed[i+1]]
			tmp = m_ed[i]
		else
			tmp = m_ed[i+1]
		end
	end
	tmp
end

init p1; init p2
@l.sort!{|a,b| a.length <=> b.length}

while ed = @l.pop
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

vertices = v.map{|e| [e]}
(0..v.size-1).each{|i| vertices[i][1] = []}
for i in 0..e.size-1
	vertices[e[i].b][1] << i
end

b_point = v[-1]
#res << b_point[0]
#begin
	

#end while b_point != curr

