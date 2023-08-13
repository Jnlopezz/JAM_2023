extends Node2D

@onready var timer: Timer = $Timer
@export var character_name: String = ''
var position_idx := 0
var rajoy_present := false

func start_rajoy() -> void:
	timer.timeout.connect(_on_time_out)
	timer.start(get_wait_time(10))
	print('timer 111')


func get_wait_time(up: int) -> int:
	var wait = randi() % up
	return wait


func walk(target_pos: Vector2) -> void:
	var npc : PopochiuCharacter = C[character_name]
	print(target_pos)
	npc.walk(target_pos)
	npc.rajoy_arrived.connect(on_rajoy_arrived)
	


func _on_time_out() -> void:
	position_idx += 1
	var pos : Vector2 = $Box.get_child(position_idx).global_position
	print(position_idx)
	walk(pos)


func on_rajoy_arrived() -> void:
	var npc : PopochiuCharacter = C[character_name]
	npc.rajoy_arrived.disconnect(on_rajoy_arrived)
	print('arrived')
	if position_idx == 1:
		rajoy_present = true
		Globals.tween_initial.emit()
		await Globals.tween_ended
		rajoy_present = false
	
	if position_idx < 2:
		timer.start(get_wait_time(10))

