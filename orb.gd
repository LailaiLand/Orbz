extends RigidBody2D

var is_next = false
var movable = false
var stop_left = false
var stop_right = false

signal dropped
signal combination

func _ready():
	connect("dropped", get_parent()._on_orb_dropped)
	connect("combination", get_parent()._on_orb_combination)



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
	var collisions = get_colliding_bodies()
	for collision in collisions:
		if collision.is_in_group("orbs"):
			_check_for_match(collision)
		else:
			continue

func _check_for_match(collision):
	if self.is_in_group("red") and collision.is_in_group("red"):
		_combine("orange", self, collision)
	elif self.is_in_group("orange") and collision.is_in_group("orange"):
		_combine("yellow", self, collision)
	elif self.is_in_group("yellow") and collision.is_in_group("yellow"):
		_combine("green", self, collision)
	elif self.is_in_group("green") and collision.is_in_group("green"):
		_combine("indigo", self, collision)
	elif self.is_in_group("indigo") and collision.is_in_group("indigo"):
		_combine("violet", self, collision)
	elif self.is_in_group("violet") and collision.is_in_group("violet"):
		_combine("pride", self, collision)

func _combine(colour, orb1, orb2):
	emit_signal("combination", colour, orb1, orb2)
