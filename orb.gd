extends RigidBody2D

var movable = false
var stop_left = false
var stop_right = false

func get_input():
	var direction
	if Input.is_action_pressed("move_left") and !stop_left:
		direction = -100
	elif Input.is_action_pressed("move_right") and !stop_right:
		direction = 100
	else :
		direction = 0
	return direction

func _physics_process(delta):
	if movable:
		position += transform.x * get_input() * delta
