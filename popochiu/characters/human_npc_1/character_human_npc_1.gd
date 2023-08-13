@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.
@onready var anim_player: AnimatedSprite2D = $Sprite2D
@export var is_player := false

const Data := preload('character_human_npc_1_state.gd')

var state: Data = load('res://popochiu/characters/human_npc_1/character_human_npc_1.tres')
var current_dialog := 0

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
	pass


# When the node is clicked
func _on_click() -> void:
	await C.HumanNPC1.say('“Aprieta el botón”, es lo único que nos dicen')
	await C.HumanNPC1.say('cada mañana al levantarnos')
	await C.HumanNPC1.say('pero lo único que conseguimos son monedas de oro')
	await C.HumanNPC1.say('que no sirven…')
	
	var response: PopochiuDialogOption = await D.show_inline_dialog(
		'Quizás “aprieta el botón” se refiere a ...',
		[
			'Que debes apretarlo muchas veces', 'A que deberíamos rendirnos con esto'
		]
	)
	
	match response.id:
		'0':
			await C.HumanNPC1.say('Es lo que he estado haciendo, Habitante 407')
			await C.HumanNPC1.say('si lo aprieto lo suficiente podré escapar de aquí.')
		'1':
			await C.HumanNPC1.say('¿Y morir a causa de las electrificaciones?')
			await C.HumanNPC1.say('pésima idea, Habitante 407')


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
	anim_player.play("idle")
	super()


func _play_hand() -> void:
	anim_player.play("hand")
	
# Use it to play the walk animation for the character
# target_pos can be used to know the movement direction
func _play_walk(target_pos: Vector2) -> void:
	anim_player.play("walk")
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
