#!/usr/bin/ruby1.9.3
require_relative "obj_reader.rb"

v, e, faces = @read_init.("obj/cube.obj")

lt = Vec3f.new(-1,-1,-1)
stack = [0]

f_flag = Array.new(faces.size) { |f| f = false }
is_cntr = Array.new(e.size) { |c| c = false }

faces.each do |f|
	ind = faces.index f
	if !f_flag[ind] && f.facial(lt)
		f_flag[ind] = true
		for i in 0..2
			curr_f = faces[e[f[i]].r]
			unless f_flag[j = faces.index(curr_f)]
				if curr_f.facial lt
					stack.push(j) 
				else
					is_cntr[f[i]] = true 
				end
			end
		end
	end
end

faces.each{|e| p e} 
p v