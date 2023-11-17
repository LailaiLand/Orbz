extends CharacterBody2D

func get_input():
	var direction
	if Input.is_action_pressed("move_left"):
		direction = -100
	elif Input.is_action_pressed("move_right"):
		direction = 100
	else :
		direction = 0
	return direction

func _physics_process(delta):
		position += transform.x * get_input() * delta
