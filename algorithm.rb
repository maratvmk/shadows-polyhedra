require_relative "obj_reader.rb"

v, e, faces = @read_init.call "obj/cube.obj"

f_flag = Array.new(faces.size) { |i| i = false }

f.each do |f|

end