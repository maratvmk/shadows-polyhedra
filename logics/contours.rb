def contours(e, faces, lt)
	f_flag, is_cntr = {}, {} ## грань обработан или нет, ребро контурный или нет
	stack, cntrs, m = [], [], 0

	for ind in 0..faces.size-1
		if !f_flag[ind] && faces[ind].facial(lt)  ## грань не обработан и лицевой
			stack.push(ind)

			while id = stack.pop ## пока стек не пуст
				f = faces[id]
				f_flag[id] = true
				for i in 0..2 ## рассмотрим все соседние грани
					curr_f = faces[e[f[i]].r]
					unless f_flag[j = faces.index(curr_f)] ## не обработан
						if curr_f.facial(lt) ## и лицевой
							stack.push(j)    ## то, положим в стек
						else 
							is_cntr[f[i]] = true ## иначе это ребро контурное 
						end
					end
				end
			end ## найдены все контурные рёбра, одной лицевой поверхности 
			
			curr_ed = cntr = is_cntr.key(true) ## одно из контурных ребер
			cntrs[m] = [cntr]
			while (curr_ed = e[curr_ed].e_next) != cntr ## построим контурный цикл из контурных рёбер
				if is_cntr[curr_ed] ## если контурный то запоминаем
					cntrs[m] << curr_ed
				else
					curr_ed = e.index(e[curr_ed].inverse)
				end
			end 
			
			m += 1
			is_cntr.clear
		end
	end
	
	return cntrs # возвр. контурный цикл и точки сборок
end