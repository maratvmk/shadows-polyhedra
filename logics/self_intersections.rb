def remove_intersections polygons, asm_prs
	for i in 0..polygons.size-1
		p = polygons[i]; psize = p.size; e = []; asm_eds = []
		for j in 0..psize-1
			e << Edge.new( b: (j-1) % psize,  e: j)
			asm_eds << j if asm_prs[i].include? p[j]
		end
		for asm in asm_eds 
			flag = false
			loop do
				break if flag
				mass = (0..psize-1).map{|e| e if ((e-asm)/7==0 or (psize+e-asm)/7==0) and (e-asm).abs % (psize-1)>1 }.compact
				for m in mass
					puts m
					if cross = e[asm].intersect(e[m], p)
						p cross
						flag = true
						break
					end
				end
				asm = (asm-1) % psize
			end
		end
	end
end