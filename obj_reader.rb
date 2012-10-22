require_relative "edge.rb"
require_relative "face.rb"

v = Array(0); f_obj = []; e = []; faces = []

init_edges = lambda do |k, n, f|
	unless i = e.index(Edge.new(b: f[k], e: f[n]))
		e << Edge.new(b: f[k], e: f[n], l: f_obj.index(f)) 
		e << Edge.new(b: f[n], e: f[k], r: f_obj.index(f))
		e.size - 2
	else
		e[i].set(r: f_obj.index(f))
		e[i+1].set(l: f_obj.index(f))
		i + 1
	end	
end

File.readlines("obj/cube.obj").each do |l|
	if l[0] == 'v' and l[1] == ' '
		v << l[2..6].split(' ').map { |e| e.to_f }
	elsif l[0] == 'f' and l[1] == ' '
	   f_obj << l[2..6].split(' ').map { |e| e.to_i }
	end
end

f_obj.each do |f|
	ab = init_edges.call(0, 1, f)
	bc = init_edges.call(1, 2, f)
	ca = init_edges.call(2, 0, f)

	faces << Face.new(a: f[0], b: f[1], c: f[2], ab: ab, bc: bc, ca: ca)
end

e.each { |e| p e }
puts 
faces.each { |e| p e }
puts e.size
puts faces.size
p e[0]