extends Node2D

@onready var timer: Timer = $Timer
@export var character_name: String = ''
var position_idx := 0
var rajoy_phase := 0
var rajoy_present := false

func start_rajoy() -> void:
	timer.timeout.connect(_on_time_out)
	timer.start(get_wait_time(10))


func get_wait_time(up: int) -> int:
	var wait = randi() % up
	return wait


func walk(target_pos: Vector2) -> void:
	var npc : PopochiuCharacter = C[character_name]
	npc.walk(target_pos)
	Globals.audio.emit('play', 'MX', 'Steps')
	npc.rajoy_arrived.connect(on_rajoy_arrived)
	


func _on_time_out() -> void:
	var npc : PopochiuCharacter = C[character_name]
	position_idx += 1
	npc.show()
	var pos : Vector2 = $Box.get_child(position_idx).global_position
	walk(pos)


func on_rajoy_arrived() -> void:
	Globals.audio.emit('stop', 'MX', 'Steps')
	var npc : PopochiuCharacter = C[character_name]
	npc.rajoy_arrived.disconnect(on_rajoy_arrived)
	
	if position_idx == 1:
		rajoy_present = true
		Globals.tween_initial.emit()
		await Globals.tween_ended
		rajoy_present = false
	
	if position_idx < 2:
		timer.start(get_wait_time(10))
	
	if position_idx == 2:
		npc.hide()
		position_idx = 0
		npc.position = $Box.get_child(position_idx).global_position
		timer.start(get_wait_time(15))


func abort_timer() -> void:
	rajoy_present = false
	timer.start(get_wait_time(15))


func add_one_phase() -> void:
	var npc : PopochiuCharacter = C[character_name]
	rajoy_phase += 1
	npc.add_rajoy_phase()
	if rajoy_phase == 4:
		Globals.end_game.emit()
		timer.stop()
		print('Game WIN!!!!')


func reset_rajoy() -> void:
	var npc : PopochiuCharacter = C[character_name]
	rajoy_phase = 0
	position_idx = 0
	rajoy_present = false
	npc.reset_rajoy()
	
