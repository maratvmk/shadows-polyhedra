def write_projection_to_file projection
	f = File.new("projection.obj", "w"); st = 1
	for i in 0..projection.size-1
	  for j in 0..projection[i].size-1
	    v = projection[i][j]
	    f.write("v #{v.x} #{v.y} #{v.z}\n")
	  end
	  tmp = ""
	  st.upto(st + projection[i].size-1){|i| tmp += i.to_s + " "}  
	  f.write("f #{tmp}\n")
	  st += projection[i].size
	end
	f.close
end