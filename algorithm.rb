#!/usr/bin/ruby1.9.3
require_relative "obj_reader.rb"

v, e, faces = @read_init.("obj/triple.obj")

lt = Vec3f.new(-1,-1,-1)
stack = []

f_flag = Array.new(faces.size) { |f| f = false } #грань обработан или нет
is_cntr = Array.new(e.size) { |c| c = false }    #ребро контурный или нет
cntr_cycles = []
cntr_cycle_borders = [0]

for ind in 0..faces.size-1
	if !f_flag[ind] && faces[ind].facial(lt)  #грань не обработан и лицевой
		stack.push ind 		
		while id = stack.pop #пока стек не пуст
			f = faces[id]
			f_flag[id] = true
			for i in 0..2 #рассмотрим все соседние грани
				curr_f = faces[e[f[i]].r]
				unless f_flag[j = faces.index(curr_f)] #не обработан
					if curr_f.facial lt #и лицевой
						stack.push(j) 
					else 
						is_cntr[f[i]] = true #иначе это ребро контурное 
					end
				end
			end
		end
		for i in 0..e.size-1
			if is_cntr[i]
				cntr = i
				break
			end 
		end		
	end
end

for i in 0..e.size-1
	if is_cntr[i]
		p e[i]
	end
end