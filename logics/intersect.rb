require_relative "../models/vec3f.rb"
require_relative "../models/edge.rb"

a = Vec3f.new 0, 0, 0
b = Vec3f.new 3, 0, 0
c = Vec3f.new 2, 4, 0

d = Vec3f.new 1, 3, 0
e = Vec3f.new 4, -5, 0
f = Vec3f.new 5, 3, 0

p1 = [b, c, a]
p2 = [f, d, e]
#p1.sort!{|x,y| x.x <=> y.x}
#p2.sort!{|x,y| x.x <=> y.x}

v = p1 + p2

l = v.map {|e| e.x  }.sort.uniq
pol = []
s1 = p1.size
s2 = p2.size
=begin
for i in 0..s1-1
	pol << Edge.new(b: i, e: (i+1) % s1)
end

for i in 0..s2-1 
	pol << Edge.new(b: i + s1, e: (i+1) % s2 + s1)
end
p pol

#p (p1+p2).sort{|v1, v2| v1.x <=> v2.x }
=end

p a < b