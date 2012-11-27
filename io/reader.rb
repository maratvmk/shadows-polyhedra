## Чтение .obj файла и начальная инициализация
v = [0]; f_obj = []; e = []; faces = []

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

init = lambda do ## Строим РСДС и грани
	f_obj.each do |f| ## Проход по массиву граней
		ab = init_edges.(0, 1, f)
		bc = init_edges.(1, 2, f)
		ca = init_edges.(2, 0, f)
		
		faces << Face.new(a: f[0], b: f[1], c: f[2], ab: ab, bc: bc, ca: ca)
	end

	e.each do |ed| ## Проход по массиву отрезков
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

@read = lambda do |file|
	File.readlines(file).each do |l| ## Находим из файла вершины и грани
		case l[0..1]
			when 'v ' then v << l[2..-1].split(' ').map { |e| e.to_f }
			when 'f ' then f_obj << l[2..-1].split(' ').map { |e| e.to_i }
		end
	end
	v.map! {|e| e = Vec3f.new(e[0], e[1], e[2])}
	init.()
end