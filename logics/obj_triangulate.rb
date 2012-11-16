f = File.new "../obj/t_"+ARGV[0], "w"
File.readlines("../obj/"+ARGV[0]).each do |l|
	case l[0..1]
		when 'f '
			tmp = l[2..-1].split(' ') 
		   if tmp.size > 3
		   	f.write "f #{tmp[0]} #{tmp[1]} #{tmp[2]}\n" 
		   	f.write "f #{tmp[2]} #{tmp[3]} #{tmp[0]}\n"
		   else
		   	f.write l
		   end
		else
			f.write l
	end
end