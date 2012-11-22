def remove_intersections polygons, asm_prs
	for i in 0..polygons.size-1
		p = polygons[i]; psize = p.size; e = []; asm_eds = []; cross = {index: []}
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
					if cr = e[asm].intersect(e[m], p) # если пересекаются, то запоминаем и break
						if asm > m
							cross[m] = [cr, asm]
							cross[:index] += (m..asm-1).to_a
						else
						 	cross[asm] = [cr, m]
						 	cross[:index] += (asm..m-1).to_a
						end
						flag = true; break
					end
				end
				asm = (asm-1) % psize
			end
		end
		for j in 0..psize-1 # удаляем ненужные вершины и строим конечный полигон 
			if cross[:index].include?(j)
				if cross[j]
					p[e[j].e] = cross[j][0]
					p[e[cross[j][1]].b] = cross[j][0]
				else
					p[j] = nil
				end
			end
		end
		p.compact!
	end
	polygons
end