require_relative "angle.rb"
stack = []; cntr_cycles = []; asm_point = []; m = 0; alpha = 0

@get_contour_cycles = lambda do |v, e, faces, lt, n|
	f_flag = Array.new(faces.size, false) # грань обработан или нет
	is_cntr = Array.new(e.size, false)   # ребро контурный или нет

	for ind in 0..faces.size-1
		if !f_flag[ind] && faces[ind].facial(lt)  # грань не обработан и лицевой
			stack.push ind
			while id = stack.pop # пока стек не пуст
				f = faces[id]
				f_flag[id] = true
				for i in 0..2 # рассмотрим все соседние грани
					curr_f = faces[e[f[i]].r]
					unless f_flag[j = faces.index(curr_f)] # не обработан
						if curr_f.facial lt # и лицевой
							stack.push j    # то, положим в стек
						else 
							is_cntr[f[i]] = true # иначе это ребро контурное 
						end
					end
				end
			end # найдены все контурные рёбра, одной лицевой поверхности 
			curr_ed = cntr = is_cntr.index true # начальное контурное ребро
			cntr_cycles[m] = []
			begin # построим контурный цикл из контурных рёбер
				alpha += angle [v[e[curr_ed].b], v[e[curr_ed].e], v[e[e[curr_ed].e_next].e]], lt, n
				curr_ed = e[curr_ed].e_next
				if is_cntr[curr_ed]
					cntr_cycles[m] << curr_ed
					asm_point << curr_ed if alpha > 360
					p alpha
					alpha = 0
				else
					curr_ed = e.index e[curr_ed].inverse
				end
			end while curr_ed != cntr
			is_cntr.map!{ |e| e = false }
			m += 1
		end
	end
	p f_flag
	cntr_cycles
end