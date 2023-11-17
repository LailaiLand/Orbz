extends CanvasLayer

@export var red_orb_scene: PackedScene
@export var orange_orb_scene: PackedScene
@export var yellow_orb_scene: PackedScene
@export var green_orb_scene: PackedScene
@export var indigo_orb_scene: PackedScene
@export var violet_orb_scene: PackedScene
@export var pride_orb_scene: PackedScene


func _ready():
	var start_orb = red_orb_scene.instantiate()
	start_orb.position = $PlacementMarker.position
	start_orb.gravity_scale = 0
	add_child(start_orb)
	start_orb.movable = true
	_random_next_orb()

#func _process(delta):
	#TODO: make drop function

func _random_next_orb():
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
	temp_next.movable = false
	temp_next.is_next = true
	add_child(temp_next)

func _new_orb():
	for orb in get_children():
		if orb.is_in_group("orbs"):
			if orb.is_next == true:
				_spawn_new_orb(orb)
				orb.queue_free()
			else:
				continue
		else:
			continue
		
	_random_next_orb()

func _on_orb_dropped():
	$DropTimer.start()

func _spawn_new_orb(orb_name):
	var orb_spawn
	if orb_name.is_in_group("red"):
		orb_spawn = red_orb_scene.instantiate()
	elif orb_name.is_in_group("orange"):
		orb_spawn = orange_orb_scene.instantiate()
	elif orb_name.is_in_group("yellow"):
		orb_spawn = yellow_orb_scene.instantiate()
	orb_spawn.position = $PlacementMarker.position
	orb_spawn.movable = true
	orb_spawn.gravity_scale = 0
	add_child(orb_spawn)

func _on_stop_left_body_entered(body):
	body.stop_left = true


func _on_drop_timer_timeout():
	_new_orb()
