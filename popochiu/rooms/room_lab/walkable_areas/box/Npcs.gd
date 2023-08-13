extends Node2D

enum Looking {UP, UP_RIGHT, RIGHT, RIGHT_DOWN, DOWN, DOWN_LEFT, LEFT, UP_LEFT}
var is_moving := false

var _looking_dir: int = Looking.DOWN
enum FlipsWhen { NONE, MOVING_RIGHT, MOVING_LEFT }


@onready var timer: Timer = $Timer
@export var character_name: String = ''

func start_npcs() -> void:
	timer.timeout.connect(_on_time_out)
	timer.start(set_wait_time())


func set_wait_time() -> int:
	var wait = randi() % 6
	return wait


func walk(target_pos: Vector2) -> void:
	var npc : PopochiuCharacter = C[character_name]
	npc.walk(target_pos)
	#TODO : start timer y subir manito


func _on_time_out() -> void:
	var child = randi() % $Box.get_child_count()
	var pos = $Box.get_child(child).global_position
	walk(pos)
	
