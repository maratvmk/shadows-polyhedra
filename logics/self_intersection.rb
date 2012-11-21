require_relative "../models/vec3f"
require_relative "../models/edge.rb"

p = []
e = []
p << Vec3f.new(0, 0, 0)
p << Vec3f.new(3, 0, 0)
p << Vec3f.new(3, 3, 0)
p << Vec3f.new(2, 3, 0)
p << Vec3f.new(2, 2, 0)
p << Vec3f.new(4, 2, 0)
p << Vec3f.new(4, 4, 0)
p << Vec3f.new(0, 4, 0)

size = p.size
for i in 0..size-1
	e << Edge.new( b: i, e: (i+1) % size) 
end

asm_point = 4
mass = []

mass = (0..p.size-1).partition{|t| t/(asm_point-1) == 0}.map{|t| t.reverse}
mass = mass[0] + mass[1]

for i in mass
	puts i
	p  e[asm_point].intersect e[i], p

end
