require 'opengl'
include Gl,Glu,Glut
require_relative "obj_reader.rb"
require_relative "algorithm.rb"

v, e, faces = @read_init.("obj/double.obj")
cntr_cycles = @get_counter_cycles.(e, faces)

display = Proc.new do
	glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
	glMatrixMode GL_MODELVIEW
  glLoadIdentity
	
	glColor3f 0.4, 0.4, 0.4
  glTranslatef -0.5, 0.0, -7.0

  glBegin GL_TRIANGLES
  faces.each do |f| 
    glVertex3f v[f.a].x, v[f.a].y, v[f.a].z
    glVertex3f v[f.b].x, v[f.b].y, v[f.b].z
    glVertex3f v[f.c].x, v[f.c].y, v[f.c].z
  end
  glEnd
	
  glLineWidth 3
  glColor3f 0.7, 0.7, 0.0
  for i in 0..cntr_cycles.size-1
    for j in 0..cntr_cycles[i].size-1 
      ed = cntr_cycles[i][j]
      glBegin GL_LINES
        glVertex3f v[e[ed].b].x, v[e[ed].b].y, v[e[ed].b].z
        glVertex3f v[e[ed].e].x, v[e[ed].e].y, v[e[ed].e].z
      glEnd
    end
  end

  glutSwapBuffers()
end

reshape = Proc.new do |width, height|
  height = 1 if height == 0
  glViewport 0, 0, width, height
  glMatrixMode GL_PROJECTION
  glLoadIdentity
  gluPerspective 45.0, width / height, 0.1, 100.0
end

keyboard = lambda do |key, x, y|
  case key
  when ?\e
    glutDestroyWindow window
    exit(0)
  end
end

glutInit
glutInitDisplayMode GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH
glutInitWindowSize 640, 480
glutInitWindowPosition 100, 100
window = glutCreateWindow "shadows of polyhedra"

glutKeyboardFunc keyboard
glutReshapeFunc reshape
glutDisplayFunc display
glutMainLoop