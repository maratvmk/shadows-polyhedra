require_relative "../models/vec3f.rb"
# площадь многоугольника найдём через векторное произведение
# за точку O берём начало координат
a = Vec3f.new 1, 0, 0
b = Vec3f.new 2, 1, 0
c = Vec3f.new 1, 2, 0
e = Vec3f.new -1, -2, 0

@n = Vec3f.new 0, 0, 1 
@d = 0

polygon = [a, b, c, e]

def get_area polygon
	area = 0
	for i in 0..p.size-1
		res = polygon[i] ^ polygon[(i+1) % polygon.size]
		if @n*res + @d > 0
			area += res.length
		else
			area -= res.length
		end
	end
	area > 0 ? area/2.0 : -area/2.0 
end

puts get_area polygon