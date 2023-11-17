extends RigidBody2D

var is_next = false
var movable = false
var stop_left = false
var stop_right = false

signal dropped

func _ready():
	connect("dropped", get_parent()._on_orb_dropped)



func _get_input():
	var direction
	if Input.is_action_pressed("move_left") and !stop_left:
		direction = -100
	elif Input.is_action_pressed("move_right") and !stop_right:
		direction = 100
	else :
		direction = - (linear_velocity.x / 2)
	return direction

func _physics_process(_delta):
	if movable:
		set_axis_velocity(Vector2(_get_input(), 0))
		if Input.is_action_just_pressed("drop"):
			movable = false
			gravity_scale = 1
			emit_signal("dropped")
	#TODO: cycle all collosions and send to _check_for_match()
	#      Also find out if that is too resource intensive/find easier way

func _check_for_match(collision):
	if self.is_in_group("red") and collision.is_in_group("red"):
		_combine("orange", self.position, collision.position)

func _combine(colour, pos1, pos2):
	pass #TODO emit signal and vectors
