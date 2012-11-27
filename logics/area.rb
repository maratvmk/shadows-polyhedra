# площадь многоугольника найдём через векторное произведение
# p - точка лежащая в плоскости проектирования  
def area pr, vrt, n, p 
	area = 0
	for i in 0..pr.size-1
		sz = pr[i].size
		for j in 0..sz-1
			v = (vrt[pr[i][j]]-p) ^ (vrt[pr[i][(j+1) % sz]] - p)
			if n*v - n*p > 0
				area += v.length
			else
				area -= v.length
			end
		end
	end
	area > 0 ? area/2.0 : -area/2.0 
end