def direction v, e, m_eds, dir
	r = m_eds[0]
	for i in 0..m_eds.size-2
		if e[m_eds[i]].send dir, e[m_eds[i+1]], v
			r = m_eds[i]
		else
			r = m_eds[i+1]
		end
	end
	r
end

def init_vrt v, e
	vrt = v.map{|e| [e]};
	(0..vrt.size-1).each{|i| vrt[i][1] = []}
	for i in 0..e.size-1
		vrt[e[i].b][1] << i
	end
	vrt
end

def union v, e 
	res = []; vrt = init_vrt v, e
	curr = b_point = vrt.size-1
	begin
		r = direction(v, e, vrt[curr][1], :right)
		res << (curr = e[r].e)
	end while curr != b_point
	res
end

def intersection v, e 
	res = []; vrt = init_vrt v, e
	curr = b_point = vrt.size-1
	begin
		r = direction(v, e, vrt[curr][1], :left)
		res << (curr = e[r].e)
	end while curr != b_point
	res
end