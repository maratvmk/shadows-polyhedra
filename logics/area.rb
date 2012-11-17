require_relative "../models/vec3f.rb"
# площадь многоугольника найдём через векторное произведение
# за точку O берём начало координат
a = Vec3f.new 1, 0, 2
b = Vec3f.new 2, 1, 2
c = Vec3f.new 1, 2, 2
e = Vec3f.new -1, 2, 2

@n = Vec3f.new 0, 0, 1 
@d = -2

polygon = [a, b, c, e]
# p - точка лежащая в плоскости проектирования  
def get_area polygon, p
	area = 0
	for i in 0..polygon.size-1
		res = (polygon[i]-p) ^ (polygon[(i+1) % polygon.size] - p)
		if @n*res + @d > 0
			area += res.length
		else
			area -= res.length
		end
	end
	area > 0 ? area/2.0 : -area/2.0 
end

puts get_area polygon, Vec3f.new(1, 5, 2)