require_relative "../models/vec3f.rb"

a = Vec3f.new 0, 0, 0
b = Vec3f.new 3, 0, 0
c = Vec3f.new 2, 4, 0

d = Vec3f.new 1, 3, 0
e = Vec3f.new 4, -5, 0
f = Vec3f.new 5, 3, 0

p1 = [b, c, a]
p2 = [f, e, d]

p (p1+p2).sort{|v1, v2| v1.x <=> v2.x }