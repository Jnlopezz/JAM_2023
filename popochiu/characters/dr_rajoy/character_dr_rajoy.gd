@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.

@onready var anim_player: AnimatedSprite2D = $Sprite2D
const Data := preload('character_dr_rajoy_state.gd')

signal rajoy_arrived
var state: Data = load('res://popochiu/characters/dr_rajoy/character_dr_rajoy.tres')
var rajoy_phase := 1

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
	pass


# When the node is clicked
func _on_click() -> void:
	# Replace the call to super() to implement your code. This only makes
	# the default behavior to happen.
	super.on_click()


# When the node is right clicked
func _on_right_click() -> void:
	# Replace the call to super() to implement your code. This only makes
	# the default behavior to happen.
	super.on_right_click()


# When the node is clicked and there is an inventory item selected
func _on_item_used(item: PopochiuInventoryItem) -> void:
	# Replace the call to super(item) to implement your code. This only
	# makes the default behavior to happen.
	super.on_item_used(item)


# Use it to play the idle animation for the character
func _play_idle() -> void:
	anim_player.play('idle_%s' % rajoy_phase)
	super()


func _walk_ended() -> void:
	emit_signal('rajoy_arrived')


func add_rajoy_phase() -> void:
	rajoy_phase += 1


func reset_rajoy() -> void:
	rajoy_phase = 1
	anim_player.play('idle_%s' % rajoy_phase)
	print('nueva phase')

# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func _play_walk(target_pos: Vector2) -> void:
	if rajoy_phase >= 5 : rajoy_phase = 4
	anim_player.play('side_%s' % rajoy_phase)
	super(target_pos)


# Use it to play the talk animation for the character
func _play_talk() -> void:
	super()


# Use it to play the grab animation for the character
func _play_grab() -> void:
	super()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func play(anim_name: String) -> void:
	pass
