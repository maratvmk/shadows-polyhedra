
def del_self_inttersections polygons, asm_point
	for i in 0..polygons.size-1
		psize = polygons[i].size; e = []; asm_mass = []
		for j in 0..psize-1
			e << Edge.new( b: j, e: (j+1) % psize)
			asm_mass << j if asm_point[i].include? polygons[i][j]
		end
		for asm in asm_mass 
			flag = false
			mass = (0..psize-1).map{|e| e if ((e - asm).abs/6 == 0 or (psize - (e - asm).abs)/6 == 0)  and ((e - asm).abs % (psize-1)) > 1 }.compact
			loop do
				break if flag
				for k in mass
					if (e[asm].intersect e[k], polygons[i]).class == Vec3f
						p e[asm].intersect e[k], polygons[i]
						flag = true
						break
					end
				end
				asm = (asm-1) % psize
			end
		end
	end
end