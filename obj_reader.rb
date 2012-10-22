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

f_obj.each do |f|
	faces << Face.new(a: f[0], b: f[1], c: f[2])

	unless i = e.index(Edge.new(b: f[0], e: f[1]))
		e << Edge.new(b: f[0], e: f[1], l: f_obj.index(f)) 
		e << Edge.new(b: f[1], e: f[0], r: f_obj.index(f))
	else
		e[i].set(r: f_obj.index(f))
		e[i+1].set(l: f_obj.index(f))
	end

	unless i = e.index(Edge.new(b: f[1], e: f[2]))
		e << Edge.new(b: f[1], e: f[2], l: f_obj.index(f)) 
		e << Edge.new(b: f[2], e: f[1], r: f_obj.index(f))
	else
		e[i].set(r: f_obj.index(f))
		e[i+1].set(l: f_obj.index(f))
	end

	unless i = e.index(Edge.new(b: f[2], e: f[0]))
		e << Edge.new(b: f[2], e: f[0], l: f_obj.index(f)) 
		e << Edge.new(b: f[0], e: f[2], r: f_obj.index(f))
	else
		e[i].set(r: f_obj.index(f))
		e[i+1].set(l: f_obj.index(f))
	end


end


p faces
