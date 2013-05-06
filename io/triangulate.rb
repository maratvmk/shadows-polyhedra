f = File.new "../obj/t_"+ARGV[0], 'w'

File.readlines("../obj/"+ARGV[0]).each do |l|
	case l[0..1]
		when 'f '
			tmp = l[2..-1].split(' ').map!{ |e| e.split('/') }
		   	if tmp.size == 4
		   		f.write("f #{tmp[0][0]} #{tmp[1][0]} #{tmp[2][0]}\n")
		   		f.write("f #{tmp[2][0]} #{tmp[3][0]} #{tmp[0][0]}\n")
		   	elsif tmp.size == 3
		   		f.write("f #{tmp[0][0]} #{tmp[1][0]} #{tmp[2][0]}\n")
		   	else
		   		puts 'Error'
		   	end
		else
			f.write l
	end
end