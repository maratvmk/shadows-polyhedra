def write_projection pr
	st = 1
	f = File.new("projection.obj", 'w')

	for i in 0..pr.size-1
	  p = pr[i]
	  sz = p.size
	  tmp = ""
	 
	  for j in 0..sz-1
	    v = p[j]
	    f.write("v #{v.x} #{v.y} #{v.z}\n")
	  end

	  (st..st + sz-1).each{|i| tmp += i.to_s + " "}  
	  f.write("f #{tmp}\n")

	  st += sz
	end
	f.close
end