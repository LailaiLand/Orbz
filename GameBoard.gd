extends CanvasLayer

@export var red_orb_scene: PackedScene
@export var orange_orb_scene: PackedScene
@export var yellow_orb_scene: PackedScene
@export var green_orb_scene: PackedScene
@export var indigo_orb_scene: PackedScene
@export var violet_orb_scene: PackedScene
@export var pride_orb_scene: PackedScene

var current_orb
var next_orb
var speed = 10
var all_orbs = []
var stop_left = false
var stop_right = false

func _ready():
	var start_orb = red_orb_scene.instantiate()
	start_orb.position = $PlacementMarker.position
	start_orb.gravity_scale = 0
	add_child(start_orb)
	current_orb = start_orb
	next_orb = random_next_orb()


func random_next_orb():
	var random_num = randi_range(1, 3)
	var temp_next
	if random_num == 1:
		temp_next = red_orb_scene.instantiate()
	elif random_num == 2:
		temp_next = orange_orb_scene.instantiate()
	elif random_num == 3:
		temp_next = yellow_orb_scene.instantiate()
	temp_next.position = $NextMarker.position
	temp_next.gravity_scale = 0
	add_child(temp_next)
	return temp_next


func get_input():
	#TODO: use _physics_prosess and move_and_slide on orbs
	pass


func _on_stop_left_body_entered(_body):
	stop_left = true


func _on_stop_left_body_exited(_body):
	stop_left = false


func _on_stop_right_body_entered(_body):
	stop_right = true


func _on_stop_right_body_exited(_body):
	stop_right = false
