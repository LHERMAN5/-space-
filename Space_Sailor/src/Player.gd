extends KinematicBody2D

var speed : int = 100
var jumpForce : int = 1000
var gravity : int = 10000
var specGrav : int = 100000000

var grav : Vector2 = Vector2()

var vel : Vector2 = Vector2()

var pos : Vector2 = Vector2()

var xdist: int = 0
var ydist: int = 0

var radius: int = 0

var unit: int = 0

var planet : Vector2 = Vector2()



onready var sprite : Sprite = get_node("Sprite")

func getRad(position, planet):
	return sqrt(pow(planet.x-position.x,2)+pow(planet.y-position.y,2))
	
func getAng(vec1,vec2):
	return atan2(vec1.y-vec2.y,vec1.x-vec2.x)

func _physics_process(delta):
	
	planet.x = 232
	planet.y = 751
	pos.x = planet.x-position.x
	pos.y = planet.y-position.y
	
	gravity = specGrav/pow(getRad(position,planet),2)
	
	print("gravity ",gravity)
	print(getRad(position,planet))
	print("grav", specGrav/pow(getRad(position,planet),2))

	
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
	if Input.is_action_pressed("move_up"):
		vel.y -= speed
	if Input.is_action_pressed("move_down"):
		vel.y += speed
		
	vel = move_and_slide(vel, Vector2.UP)
	
	unit = sqrt(pos.x*pos.x+pos.y*pos.y)
	
	if pos.x*delta != 0:
		vel.x += pos.x*delta*gravity/unit
	if pos.y*delta != 0:
		vel.y += pos.y*delta*gravity/unit
	
	#jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
		
	
	#flip sprite
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false

