extends CanvasLayer

@export var red_orb_scene: PackedScene
@export var orange_orb_scene: PackedScene
@export var yellow_orb_scene: PackedScene
@export var green_orb_scene: PackedScene
@export var indigo_orb_scene: PackedScene
@export var violet_orb_scene: PackedScene
@export var pride_orb_scene: PackedScene

var round_count = 0
var end_orbs = []
var score = 0
var current_combination = []

func _ready():
	$FillLine.self_modulate = Color(1, 1, 1, 1)
	var start_orb = red_orb_scene.instantiate()
	start_orb.position = $PlacementMarker.position
	start_orb.gravity_scale = 0
	add_child(start_orb)
	start_orb.movable = true
	_random_next_orb()

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
	_increase_round()
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

func _on_orb_dropped():
	$DropTimer.start()

func _on_orb_combination(colour, orb1, orb2):
	if !current_combination.is_empty():
		pass
	current_combination.push_front(orb1)
	current_combination.push_front(orb2)
	var combined_orb
	if orb1.movable or orb2.movable:
		_game_over("Knocked yourself out!")
	var temp_vector = orb1.position
	if colour == "orange":
		combined_orb = orange_orb_scene.instantiate()
	elif colour == "yellow":
		combined_orb = yellow_orb_scene.instantiate()
	elif colour == "green":
		combined_orb = green_orb_scene.instantiate()
	elif colour == "indigo":
		combined_orb = indigo_orb_scene.instantiate()
	elif colour == "violet":
		combined_orb = violet_orb_scene.instantiate()
	elif colour == "pride":
		combined_orb = pride_orb_scene.instantiate()
	combined_orb.position = temp_vector
	add_child(combined_orb)
	current_combination.clear()
	remove_child(orb1)
	remove_child(orb2)

func _increase_round():
	round_count += 1
	$RoundNumberLabel.text = str(round_count)

func _game_over(message):
	$OverMessageLabel.text = message
	for child in get_children():
		if child.is_in_group("orbs"):
			if child.movable or child.is_next:
				remove_child(child)
			end_orbs.push_front(child)
	_calculate_score()

func _calculate_score():
	pass #TODO run through end_orbs[] and calculate score

func _on_stop_left_body_entered(body):
	body.stop_left = true


func _on_stop_right_body_entered(body):
	body.stop_right = true


func _on_stop_left_body_exited(body):
	body.stop_left = false


func _on_stop_right_body_exited(body):
	body.stop_right = false

func _on_drop_timer_timeout():
	_new_orb()

func _on_out_of_bounds_body_entered(_body):
	_game_over("Orb fell out of the world!")


func _on_full_up_body_entered(body):
	if body.is_in_group("orbs") and !body.movable and $FullUpTimer.is_stopped():
		$FullUpTimer.start()
	$FillLine.self_modulate = Color(1, 0.02, 0.02, 1)

func _on_full_up_body_exited(_body):
	if !$FullUpTimer.is_stopped():
		$FullUpTimer.stop()
	$FillLine.self_modulate = Color(1, 1, 1, 1)


func _on_full_up_timer_timeout():
	_game_over("Box is full!")
