require 'opengl'
include Gl,Glu,Glut
require_relative "obj_reader.rb"

v, e, faces = @read_init.("obj/double.obj")

display = Proc.new do
	glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
	glMatrixMode GL_MODELVIEW
  glLoadIdentity
	
	glColor3f(0.0, 0.6, 0.0)
  glTranslatef 0.0, 0.0, -6.0

  glBegin GL_TRIANGLES
  faces.each do |f| 
    glVertex3f v[f.a].x, v[f.a].y, v[f.a].z
    glVertex3f v[f.b].x, v[f.b].y, v[f.b].z
    glVertex3f v[f.c].x, v[f.c].y, v[f.c].z
  end
  glEnd
	
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
glutCreateWindow "shadows of polyhedra"

glutKeyboardFunc keyboard
glutReshapeFunc reshape
glutDisplayFunc display
glutMainLoop