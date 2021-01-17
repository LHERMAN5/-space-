extends KinematicBody2D

var gravity : int = 0

var vel : Vector2 = Vector2()
var accel : Vector2 = Vector2()

var planet = [Vector2(1430,966),Vector2(2660,475),Vector2(4430,1173),Vector2(5785,-641),Vector2(6425,1339),Vector2(8726,-11),Vector2(9526,562),Vector2(12237,-557),Vector2(17714,1598),Vector2(16587,647),Vector2(18935,598),Vector2(20798,537),Vector2(7854,711),Vector2(11388,805),Vector2(13606,385),Vector2(15262,-770)]
var standGrav = 10000000
var specGrav = [.5,1,.6,1,.8,.5,1,.6,.9,.4,1,1,.3,.8,.7,.4]

var start=false

func getRad(position, planet):
	return sqrt(pow(planet.x-position.x,2)+pow(planet.y-position.y,2))*.1
	
func getAng(vec1,vec2):
	return atan2(vec1.y-vec2.y,vec1.x-vec2.x)

func _physics_process(delta):
	
	if Input.is_action_pressed("dive"):
		start = true
		
	if Input.is_action_pressed("reset"):
		position = Vector2(-1110.947,970.375)
		vel = Vector2(0,0)
		start = false
		
	accel = Vector2(0,0)
	for i in range(planet.size()):
		gravity = standGrav*specGrav[i]/pow(getRad(position,planet[i]),2)
		if Input.is_action_pressed("dive") and not is_on_floor():
			gravity *= 10
		accel.x += -gravity*cos(getAng(position,planet[i]))
		accel.y += -gravity*sin(getAng(position,planet[i]))
		
	if !start:
		accel = Vector2()
		
	vel.x += delta*accel.x
	vel.y += delta*accel.y
	
	vel = move_and_slide(vel, Vector2.UP)
	


