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
	elif stop_left or stop_right or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right") :
		direction = 0
	else :
		direction = 0
	return direction

func _physics_process(delta):
	if movable:
		set_axis_velocity(Vector2(get_input(), 0))
		if Input.is_action_just_pressed("drop"):
			movable = false
			gravity_scale = 1
