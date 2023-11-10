extends CanvasLayer

@export var red_orb_scene: PackedScene
@export var orange_orb_scene: PackedScene
@export var yellow_orb_scene: PackedScene
@export var green_orb_scene: PackedScene
@export var indigo_orb_scene: PackedScene
@export var violet_orb_scene: PackedScene
@export var pride_orb_scene: PackedScene


var next_orb

func _ready():
	var start_orb = red_orb_scene.instantiate()
	start_orb.position = $PlacementMarker.position
	start_orb.gravity_scale = 0
	add_child(start_orb)
	start_orb.movable = true
	next_orb = random_next_orb()

#func _process(delta):
	#TODO: make drop function

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
	temp_next.movable = false
	return temp_next

func new_orb():
	next_orb.position = $PlacementMarker.position
	next_orb.movable = true
	random_next_orb()

func _on_stop_left_body_entered(body):
	body.stop_left = true
	print(body.name)


func _on_stop_left_body_exited(body):
	body.stop_left = false
	print(body.name)


func _on_stop_right_body_entered(body):
	body.stop_right = true
	print(body.name)


func _on_stop_right_body_exited(body):
	body.stop_right = false
	print(body.name)
