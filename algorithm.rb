#!/usr/bin/ruby1.9.3
require_relative "obj_reader.rb"

v, e, faces = @read_init.("obj/untitled.obj")

lt = Vec3f.new(-1,-1,-1)
stack = []

f_flag = Array.new(faces.size) { |f| f = false } # грань обработан или нет
is_cntr = Array.new(e.size) { |c| c = false }    # ребро контурный или нет

for ind in 0..faces.size-1
	if !f_flag[ind] && faces[ind].facial(lt)
		stack.push ind 		
		while ind = stack.pop
			f = faces[ind]
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
end


for i in 1..36
	if is_cntr[i] == true
		p e[i]
	end
end