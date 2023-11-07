extends CanvasLayer

var current_orb = []
var next_orb = []
var all_orbs = []
var stop_left = false
var stop_right = false

var speed = 10

@export var red_orb_scene: PackedScene
@export var orange_orb_scene: PackedScene
@export var yellow_orb_scene: PackedScene
@export var green_orb_scene: PackedScene
@export var indigo_orb_scene: PackedScene
@export var violet_orb_scene: PackedScene
@export var pride_orb_scene: PackedScene

func _ready():
	var start_orb = red_orb_scene.instantiate()
	start_orb.gravity_scale = 0
	start_orb.position = $NextMarker.position
	add_child(start_orb)
	next_orb.push_front(start_orb)
	new_orb()

func get_input():
	var input_direction
	if !stop_left and Input.is_action_just_pressed("move_left"):
		input_direction = Vector2(-1, 0)
	elif !stop_right and Input.is_action_just_pressed("move_right"):
		input_direction = Vector2(1, 0)
	else:
		input_direction = Vector2.ZERO
	$PlacementMarker.position = $PlacementMarker.position + input_direction * speed

func _process(delta):
	current_orb[0].position = $PlacementMarker.position
	get_input()
	if Input.is_action_just_pressed("drop"):
		drop()
	

func new_orb():
	$PlacementMarker.position = Vector2(512, 56)
	current_orb.push_front(next_orb[0])
	next_orb.clear()
	next_orb.push_front(get_random_orb())
	
	

func get_random_orb():
	var rand_num = randi_range(1, 3)
	var rand_orb
	if rand_num == 1 :
		rand_orb = red_orb_scene.instantiate()
	elif rand_num == 2 :
		rand_orb = orange_orb_scene.instantiate()
	elif rand_num == 3 :
		rand_orb = yellow_orb_scene.instantiate()
	rand_orb.position = $NextMarker.position
	rand_orb.gravity_scale = 0
	add_child(rand_orb)
	return rand_orb

func drop():
	#TODO add a timer and shit to make this work
