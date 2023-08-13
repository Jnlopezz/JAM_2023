extends Node2D

@onready var timer: Timer = $Timer
@export var character_name: String = ''
var positions : Array


func start_npcs() -> void:
	positions.clear()
	for pos in $Box.get_children():
		positions.append(pos.global_position)
		
	positions.shuffle()
	timer.timeout.connect(_on_time_out)
	timer.start(get_wait_time(6))


func get_wait_time(up: int) -> int:
	var wait = randi() % up
	return wait


func walk(target_pos: Vector2) -> void:
	var npc : PopochiuCharacter = C[character_name]
	npc.npc_arrived.connect(on_npc_arrived)
	npc.walk(target_pos)
	#TODO : start timer y subir manito


func _on_time_out() -> void:
	positions.push_back(positions[0])
	positions.pop_front()
	var pos = positions[0]
	walk(pos)


func on_npc_arrived() -> void:
	var npc : PopochiuCharacter = C[character_name]
	npc.npc_arrived.disconnect(on_npc_arrived)
	timer.start(get_wait_time(10))
