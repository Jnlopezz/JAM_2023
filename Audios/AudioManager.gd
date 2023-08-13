extends Node2D

var sources: Array = []

func _ready():
	for src in get_children():
		sources.append(src.name)
	
	Globals.audio.connect(on_audio)


func on_audio(key: String, source:= '', sound:= '') -> void:
	var node = get_audio(source, sound)
	match key:
		'play':
			node.play()
		'stop':
			node.stop()


func get_audio(source, sound) -> Node:
	var node : Node = get_node('' + source + '/' + sound)
	return node
