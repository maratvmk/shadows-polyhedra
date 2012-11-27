require 'opengl'
include Gl,Glu,Glut

require_relative "models/edge.rb"
require_relative "models/face.rb"

require_relative "io/reader.rb"
require_relative "io/projection_writer.rb"

require_relative "logics/contours.rb"
require_relative "logics/projection.rb"
require_relative "logics/linear-nodal.rb"
require_relative "logics/overlay.rb"

lt = Vec3f.new 1, 2, 1
n = Vec3f.new 1, 1, 1
p = Vec3f.new 0, 0, -5
v, e, faces = @read.("obj/t_n.obj")

cntrs = contours(v, e, faces, lt, n)
old_pr = project(v, e, cntrs, n, p, lt)

vrt, eds, cr_range, p_border = init_linear_nodal old_pr
pr = union vrt, eds, cr_range, p_border

#write_projection pr
#p cntrs

@ambient = [0.1, 0.5, 0.5, 1.0]
@diffuse = [0.4, 0.4, 1.0, 1.0]
@light_position = [-1.0, -1.0, -1.0, 0.4]
window = ""
## флаги для появления и исчизновения объектов
obj = true; cc = proj = old_proj = false

def init_gl
  glShadeModel GL_SMOOTH

  glLightfv GL_LIGHT1, GL_AMBIENT, @ambient
  glLightfv GL_LIGHT1, GL_DIFFUSE, @diffuse
  glLightfv GL_LIGHT1, GL_POSITION, @light_position

  glEnable GL_LIGHT1
end

display = Proc.new do
  puts 'aaaaaa'
	glClear GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT
	glMatrixMode GL_MODELVIEW
  glLoadIdentity
	glEnable GL_DEPTH_TEST

  glEnable GL_LIGHTING
	glColor3f 0.4, 0.4, 0.4
  glTranslatef 0.5, 0.0, -7.0

  glScalef(0.4, 0.4, 0.4)
  glRotatef(30, 1, 1, 1)

  # Рисуем сам объект
  if obj
    glBegin GL_TRIANGLES 
      faces.each do |f|
        glNormal3f f.n.x, f.n.y, f.n.z
        glVertex3f v[f.a].x, v[f.a].y, v[f.a].z
        glVertex3f v[f.b].x, v[f.b].y, v[f.b].z
        glVertex3f v[f.c].x, v[f.c].y, v[f.c].z
      end
    glEnd
  end

  
  glDisable GL_LIGHTING
  ## Рисуем контурный цикл
  if cc
    glLineWidth 3
    glColor3f 1.0, 1.0, 0.0
    for i in 0..cntrs.size-1
      for j in 0..cntrs[i].size-1 
        ed = cntrs[i][j]
        glBegin GL_LINES
          glVertex3f v[e[ed].b].x, v[e[ed].b].y, v[e[ed].b].z
          glVertex3f v[e[ed].e].x, v[e[ed].e].y, v[e[ed].e].z
        glEnd
      end
    end
  end

  ## Рисуем проекцию контурного цикла
  glLineWidth 1
  glColor3f 1.0, 1.0, 1.0

  if proj
    for i in 0..pr.size-1
      for j in 0..pr[i].size-1
        vt = vrt[pr[i][j]]
        vt2 = vrt[pr[i][(j+1) % pr[i].size]]
        glBegin GL_LINES
          glVertex3f vt.x, vt.y, vt.z
          glVertex3f vt2.x, vt2.y, vt2.z
        glEnd
      end
    end
  else
    if old_proj 
      for i in 0..old_pr.size-1
        for j in 0..old_pr[i].size-1
          vt = old_pr[i][j]
          vt2 = old_pr[i][(j+1) % old_pr[i].size]
          glBegin GL_LINES
            glVertex3f vt.x, vt.y, vt.z
            glVertex3f vt2.x, vt2.y, vt2.z
          glEnd
        end
      end
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
    when 'o' then obj = !obj
    when 'c' then cc = !cc
    when 'p' then proj = !proj
    when 's' then old_proj = !old_proj
  end
  glutPostRedisplay
end

glutInit
glutInitDisplayMode GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH | GLUT_ALPHA
glutInitWindowSize 940, 705
glutInitWindowPosition 100, 10
window = glutCreateWindow "shadows of polyhedra"

glutKeyboardFunc keyboard
glutReshapeFunc reshape
glutDisplayFunc display
init_gl
glutMainLoop