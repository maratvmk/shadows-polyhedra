require_relative "edge.rb"
require_relative "face.rb"

v = Array(0); f_obj = []; e = []; faces = []

File.readlines("obj/cube.obj").each do |l|
	if l[0] == 'v' and l[1] == ' '
		v << l[2..6].split(' ').map { |e| e.to_f }
	elsif l[0] == 'f' and l[1] == ' '
	   f_obj << l[2..6].split(' ').map { |e| e.to_i }
	end
end

init_edges = lambda do |k, n, f|
	index = f_obj.index f
	unless i = e.index(Edge.new(b: f[k], e: f[n]))
		e << Edge.new(b: f[k], e: f[n], l: index)
		e << Edge.new(b: f[n], e: f[k], r: index)
		e.size - 2
	else
		e[i-1].set(r: index)
		e[i].set(l: index)
		i
	end	
end

f_obj.each do |f|
	ab = init_edges.call(0, 1, f)
	bc = init_edges.call(1, 2, f)
	ca = init_edges.call(2, 0, f)
	
	faces << Face.new(a: f[0], b: f[1], c: f[2], ab: ab, bc: bc, ca: ca)
end

e.each do |ed|
	case e.index(ed) 
		when faces[ed.l].ab then ed.e_next = faces[ed.l].bc
		when faces[ed.l].bc then ed.e_next = faces[ed.l].ca
		when faces[ed.l].ca then ed.e_next = faces[ed.l].ab
	end
	case i = e.index(ed.inverse) 
		when faces[ed.r].ab then ed.b_next = faces[ed.r].bc
		when faces[ed.r].bc then ed.b_next = faces[ed.r].ca
		when faces[ed.r].ca then ed.b_next = faces[ed.r].ab
		else puts i
	end				
end


e.each { |e| p e  }
puts 
faces.each { |e|  p e }
