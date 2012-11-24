require 'opengl'
include Gl,Glu,Glut
require_relative "io/reader.rb"
require_relative "logics/contours.rb"
require_relative "logics/projection.rb"
require_relative "io/projection_writer.rb"
require_relative "logics/self_intersections.rb"
require_relative "logics/linear-nodal.rb"
require_relative "logics/overlay.rb"

lt = Vec3f.new -1, 2, 1
n = Vec3f.new 1, 1, 1
p = Vec3f.new 0, 0, -5
v, e, faces = @read.("obj/double.obj")

cntrs, asm_points = @get_contours.(v, e, faces, lt, n)
pr, asm_prs = project(v, e, cntrs, n, p, lt, asm_points)
remove_intersections(pr, asm_prs) unless asm_prs.all?{|e| e.empty?}

vrt, eds = init_linear_nodal pr[0], pr[1]
pr = intersection vrt, eds 
p pr
puts 'a'
#write_projection pr

#p cntrs
#p asm_points
#p asm_prs

@ambient = [0.1, 0.5, 0.5, 1.0]
@diffuse = [0.4, 0.4, 1.0, 1.0]
@light_position = [-1.0, -1.0, -1.0, 0.4]
window = ""

def init_gl
  glShadeModel GL_SMOOTH

  glLightfv GL_LIGHT1, GL_AMBIENT, @ambient
  glLightfv GL_LIGHT1, GL_DIFFUSE, @diffuse
  glLightfv GL_LIGHT1, GL_POSITION, @light_position

  glEnable GL_LIGHT1
  true
end

display = Proc.new do
	glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
	glMatrixMode GL_MODELVIEW
  glLoadIdentity
	glEnable GL_DEPTH_TEST

  glEnable GL_LIGHTING
	glColor3f 0.4, 0.4, 0.4
  glTranslatef 0.5, 0.0, -7.0

  glScalef(0.6, 0.6, 0.6)
  glRotatef(30, 1, 1, 1)
  # Рисуем сам объект
  glBegin GL_TRIANGLES 
  faces.each do |f|
    glNormal3f f.n.x, f.n.y, f.n.z
    glVertex3f v[f.a].x, v[f.a].y, v[f.a].z
    glVertex3f v[f.b].x, v[f.b].y, v[f.b].z
    glVertex3f v[f.c].x, v[f.c].y, v[f.c].z
  end
  glEnd

  glDisable GL_DEPTH_TEST
  glDisable GL_LIGHTING
  # Рисуем контурный цикл
  glLineWidth 2
  glColor3f 1.0, 1.0, 0.0
  for i in 0..cntrs.size-1
    for j in 0..cntrs[i].size-1 
      ed = cntrs[i][j]
#=begin
      if asm_points.include? ed
        glColor3f 1.0, 0.0, 0.0
      else
        glColor3f 1.0, 1.0, 0.0
      end
#=end
      glBegin GL_LINES
        glVertex3f v[e[ed].b].x, v[e[ed].b].y, v[e[ed].b].z
        glVertex3f v[e[ed].e].x, v[e[ed].e].y, v[e[ed].e].z
      glEnd
    end
  end
=begin
  # Рисуем проекцию контурного цикла
  glColor3f 1.0, 1.0, 1.0
  for i in 0..pr.size-1
    for j in 0..pr[i].size-1
      vt = pr[i][j]
      vt2 = pr[i][(j+1) % pr[i].size]
      glBegin GL_LINES
        glVertex3f vt.x, vt.y, vt.z
        glVertex3f vt2.x, vt2.y, vt2.z
      glEnd
    end
  end
=end
    glColor3f 1.0, 1.0, 1.0
    for i in 0..pr.size-1
      vt = vrt[pr[i]]
      vt2 = vrt[pr[ (i+1) % pr.size]]
      glBegin GL_LINES
        glVertex3f vt.x, vt.y, vt.z
        glVertex3f vt2.x, vt2.y, vt2.z
      glEnd
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
glutInitDisplayMode GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH | GLUT_ALPHA
glutInitWindowSize 640, 480
glutInitWindowPosition 100, 100
window = glutCreateWindow "shadows of polyhedra"

glutKeyboardFunc keyboard
glutReshapeFunc reshape
glutDisplayFunc display
init_gl
glutMainLoop