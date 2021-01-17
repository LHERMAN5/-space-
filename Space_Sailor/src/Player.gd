extends KinematicBody2D

var speed : int = 100
var jumpForce : int = 1000
var gravity : int = 0

var vel : Vector2 = Vector2()

var xdist: int = 0
var ydist: int = 0

var unit: int = 0

var planet = [Vector2(232,751),Vector2(2440,300)]
var specGrav = [1000000,10500000]




onready var sprite : Sprite = get_node("Sprite")

func getRad(position, planet):
	return sqrt(pow(planet.x-position.x,2)+pow(planet.y-position.y,2))*.1
	
func getAng(vec1,vec2):
	return atan2(vec1.y-vec2.y,vec1.x-vec2.x)

func _physics_process(delta):
	
	print(planet)
	print(planet[0])
	print(vel)
	print(specGrav)
	
	for i in range(2):
		gravity = specGrav[i]/pow(getRad(position,planet[i]),2)
		vel.x += -delta*gravity*cos(getAng(position,planet[i]))
		vel.y += -delta*gravity*sin(getAng(position,planet[i]))
	
	
	
	#key movement
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
	if Input.is_action_pressed("move_up"):
		vel.y -= speed
	if Input.is_action_pressed("move_down"):
		vel.y += speed
	#jump
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_on_ceiling() or is_on_wall()):
		vel.y -= jumpForce
		
	if Input.is_action_pressed("dive"):
		gravity += 1000000
	else:
		gravity = 10000000
		
	vel = move_and_slide(vel, Vector2.UP)

