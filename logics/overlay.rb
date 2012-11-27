def direction v, e, eds, dir
	r = eds[0]
	for i in 0..eds.size-2
		if e[eds[i]].send dir, e[eds[i+1]], v
			r = eds[i]
		else
			r = eds[i+1]
		end
	end 
	r
end

def init_vrt v, e
	vrt = v.map{ |e| [e] }
	(0..vrt.size-1).each{ |i| vrt[i][1] = [] }
	for i in 0..e.size-1
		vrt[e[i].b][1] << i
	end
	vrt
end

def overlay v, e, cr_range, p_border, dir
	cr = cr_range.to_a; cr_b = cr[0]
	res = []; sz = -1; vrt = init_vrt v, e

	while curr = b_point = cr.pop
		sz += 1; res[sz] = []
		begin
			cr.delete curr if curr >= cr_b
			r = direction(v, e, vrt[curr][1], dir)
			res[sz] << (curr = e[r].e)
		end while curr != b_point
	end

	p_border.each do |p|
		res << p.to_a
	end

	res
end

def union v, e, cr_range, p_border
	overlay v, e, cr_range, p_border, :right
end

def intersection v, e, cr_range
	overlay v, e, cr_range, [], :left
end