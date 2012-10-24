## Чтение .obj файла и начальная инициализация

require_relative "edge.rb"
require_relative "face.rb"

v = Array(0); f_obj = []; e = []; faces = []

init_edges = lambda do |k, n, f|
	ind = f_obj.index(f)
	unless i = e.index(Edge.new(b: f[k], e: f[n]))
		e << Edge.new(b: f[k], e: f[n], l: ind)
		e << Edge.new(b: f[n], e: f[k], r: ind)
		e.size - 2
	else
		e[i-1].set(r: ind)
		e[i].set(l: ind)
		i
	end	
end

## Строим РСДС и грани, нужным образом
init = lambda do
	## Проход по массиву граней
	f_obj.each do |f|
		ab = init_edges.call(0, 1, f)
		bc = init_edges.call(1, 2, f)
		ca = init_edges.call(2, 0, f)
		
		faces << Face.new(a: f[0], b: f[1], c: f[2], ab: ab, bc: bc, ca: ca)
	end

	## Проход по массиву отрезков
	e.each do |ed|
		l_face = faces[ed.l]; r_face = faces[ed.r]
		case e.index(ed) 
			when l_face.ab then ed.e_next = l_face.bc
			when l_face.bc then ed.e_next = l_face.ca
			when l_face.ca then ed.e_next = l_face.ab
		end
		case e.index(ed.inverse) 
			when r_face.ab then ed.b_next = r_face.bc
			when r_face.bc then ed.b_next = r_face.ca
			when r_face.ca then ed.b_next = r_face.ab
		end				
	end
	[v, e, faces.each { |f| f.norm v }]
end

@read_init = lambda do |file|
	## Находим из файла вершины и грани
	File.readlines(file).each do |l|
		case l[0..1]
			when 'v ' then v << l[2..6].split(' ').map { |e| e.to_f }
			when 'f ' then f_obj << l[2..6].split(' ').map { |e| e.to_i }
		end
	end
	v.map! {|e| e = Vec3f.new(e[0], e[1], e[2])}
	init.call
end