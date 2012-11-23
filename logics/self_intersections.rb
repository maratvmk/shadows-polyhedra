def remove_intersections polygons, asm_prs
	for i in 0..polygons.size-1
		p = polygons[i]; psize = p.size; e = []; asm_eds = []
		for j in 0..psize-1 
			e << Edge.new( b: (j-1) % psize,  e: j)  # строим полигон сост. из рёбер
			asm_eds << j if asm_prs[i].include? p[j] # рёбра возможных самопересечений инцидентные к точкам сборок
		end
		for asm in asm_eds # ищем самопересечения вблизи точек сборок
			flag = false
			loop do
				break if flag
				mass = (0..psize-1).map{|e| e if ((e-asm)/7==0 or (psize+e-asm)/7==0) and (e-asm).abs % (psize-1)>1 }.compact
				for m in mass
					if cr = e[asm].intersect(e[m], p) # если пересекаются
						if asm > m 
							p[e[m].e] = cr  # изменяем конец вершины
							(m+1..asm-1).each{|n| p[n] = nil } # удаляем вершины которые попали внутрь самопересечения 
						else 
							p[e[asm].e] = cr
							(asm+1..m-1).each { |n| p[n] = nil }
						end
						flag = true; break
					end
				end
				asm = (asm-1) % psize # пересечение не нашли, то движемся назад на одно ребро
			end
		end
		p.compact! # удаляем nil-ы
	end
end