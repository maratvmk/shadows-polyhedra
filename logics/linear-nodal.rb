require_relative "../models/vec3f.rb"
require_relative "../models/edge.rb"

a = Vec3f.new 0, 0, 0
b = Vec3f.new 3, 0, 0
c = Vec3f.new 2, 4, 0

d = Vec3f.new 1, 3, 0
e = Vec3f.new 4, -4, 0
f = Vec3f.new 5, 3, 0

p1 = [a, b, c]
p2 = [d, e, f]
#p1.sort!{|x,y| x.x <=> y.x}
#p2.sort!{|x,y| x.x <=> y.x}
e = []; @l = []
v = (p1 + p2).uniq{|e| [e.x, e.y]}

def init p
	offset = @l.size
	for i in 0..p.size-1
		@l << Edge.new(b: i + offset, e: (i+1)%p.size + offset, length: (p[i]-p[(i+1)%p.size]).length)
	end
end

init(p1); init(p2)

@l.sort!{|a,b| a.length <=> b.length}

@l.each { |e| p e }