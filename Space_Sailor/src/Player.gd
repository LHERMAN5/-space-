extends KinematicBody2D

var speed : int = 100
var jumpForce : int = 600
var gravity : int = 800

var grav : Vector2 = Vector2()

var vel : Vector2 = Vector2()

var pos : Vector2 = Vector2()

var xdist: int = 0
var ydist: int = 0

var radius: int = 0

var unit: int = 0


onready var sprite : Sprite = get_node("Sprite")
onready var player : Node2D = get_node("Player")


func _physics_process(delta):
	
	
	pos.x = 232-position.x
	pos.y = 751-position.y

	
	
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		
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

