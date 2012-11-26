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
	vrt = v.map{|e| [e]}
	(0..vrt.size-1).each{|i| vrt[i][1] = []}
	for i in 0..e.size-1
		vrt[e[i].b][1] << i
	end
	vrt
end

def overlay v, e, dir
	res = []; vrt = init_vrt v, e
	curr = b_point = vrt.size-1
	begin
		r = direction(v, e, vrt[curr][1], dir)
		res << (curr = e[r].e)
	end while curr != b_point
	res
end

def union v, e
	overlay v, e, :right
end

def intersection v, e
	overlay v, e, :left
end