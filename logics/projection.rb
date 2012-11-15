require_relative "../models/vec3f.rb"
# плоскость в которую будем проектировать 
# задаем  через нормаль и точку лежащей на ней
n = Vec3f.new 1, 0, 0
p = Vec3f.new 1, 1, 1

lt = Vec3f.new 1, 1, 1
point = Vec3f.new 10, 9, 6
# n = (A,B,C)
# r=r0+a*t
# Ax+By+Cz+D=0 => n*r+D=0 => t = -(D+n*r0)/(n*a)

D = -(n * p)
t = -(D + n*point)/(n*lt)

puts t



