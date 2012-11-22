@f = File.new("projection.obj", "w")
@st = 1; @tmp = ""

def write_projection pr
	for i in 0..pr.size-1
	  p = pr[i]; psize = p.size 
	  for j in 0..psize-1
	    v = p[j]
	    @f.write("v #{v.x} #{v.y} #{v.z}\n")
	  end
	  @st.upto(@st + psize-1){|i| @tmp += i.to_s + " "}  
	  @f.write("f #{@tmp}\n")
	  @st += psize
	end
	@f.close
end