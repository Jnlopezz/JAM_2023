@tool
extends PopochiuRoom

const Data := preload('room_room_lab_state.gd')

var state: Data = load('res://popochiu/rooms/room_lab/room_room_lab.tres')

var goal_to_coin := 1
var current_coins := 0
var coin_visible := 0
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
# TODO: Overwrite Godot's methods


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# What happens when Popochiu loads the room. At this point the room is in the
# tree but it is not visible
func _on_room_entered() -> void:
	Globals.tween_ended.connect(on_timer_completed)
	Globals.abort_tween.connect(_on_abort_tween)
	Globals.restart_game.connect(_on_restart)
	Globals.audio.emit('play', 'MX', 'Ambient')
	$Props.get_node('Button').botton_done.connect(on_button_done)
	$Characters.y_sort_enabled = true
	$Props.y_sort_enabled = true


# What happens when the room changing transition finishes. At this point the room
# is visible.
func _on_room_transition_finished() -> void:
	await C.Narra.say('Aprieta el botón!')
	Globals.dialog_ended.emit()
	$Npcs1.start_npcs()
	$Npcs2.start_npcs()
	$Rajoy.start_rajoy()


# What happens before Popochiu unloads the room.
# At this point, the screen is black, processing is disabled and all characters
# have been removed from the $Characters node.
func _on_room_exited() -> void:
	pass


func on_timer_completed() -> void:
	if $Rajoy.rajoy_present:
		C.Human.punir()
		$Rajoy.add_one_phase()


func _on_abort_tween() -> void:
	$Rajoy.abort_timer()


func on_button_done() -> void:
	Globals.reward.emit()
	if current_coins == goal_to_coin:
		if coin_visible >= $Coins.get_child_count(): return
		$Coins.get_child(coin_visible).show()
		coin_visible += 1
		goal_to_coin = goal_to_coin * 2
	
	current_coins += 1


func _on_restart() -> void:
	$Rajoy.reset_rajoy()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
# You could put public functions here


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
# You could put private functions here
