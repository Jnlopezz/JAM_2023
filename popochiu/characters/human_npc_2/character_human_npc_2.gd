@tool
extends PopochiuCharacter
# You can use E.queue([]) to trigger a sequence of events.
# Use await E.queue([]) if you want to pause the excecution of
# the function until the sequence of events finishes.
@onready var anim_player: AnimatedSprite2D = $Sprite2D
var current_dialog := -1
var hand_raised := false
signal npc_arrived

const Data := preload('character_human_npc_2_state.gd')

var state: Data = load('res://popochiu/characters/human_npc_2/character_human_npc_2.tres')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
# When the room in which this node is located finishes being added to the tree
func _on_room_set() -> void:
	pass


# When the node is clicked
func _on_click() -> void:
	if not hand_raised: return
	current_dialog = wrapi(current_dialog +1, 0, 4)
	match current_dialog:
		0:
			await C.HumanNPC2.say('Saludos, 407')
			await C.HumanNPC2.say('¿no te cansas de apretar el botón?')
			await C.HumanNPC2.say('mi consejo es que dejes de hacerlo')
			await C.HumanNPC2.say('El Señor Rajoy no puede castigarte más que con electrificación')
			
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				'¿Qué es lo peor que puede pasar?',
				[
					'Nunca es tarde para comenzar', 'Morir en el intento'
				]
			)
			
			match response.id:
				'0':
					await C.HumanNPC2.say('Intentalo de nuevo')
					Globals.dialog_ended.emit()
					
				'1':
					await C.HumanNPC2.say('resiste dos castigos en presencia del El Señor Rajoy')
					await C.HumanNPC2.say('y entonces verás como todo tomará forma')
					await C.HumanNPC2.say('no es rendirse, es una manera de luchar.')
					Globals.dialog_ended.emit()
			
		
		1:
			await C.HumanNPC2.say('Qué fácil es vivir, ¿no crees?')
			await C.HumanNPC2.say('todo es cuestión de perspectivas')
			await C.HumanNPC2.say('de la manera en que las cambias para darle forma a lo que antes')
			await C.HumanNPC2.say('no tenía apariencia ni nombre.')
			await C.HumanNPC2.say('Pero dime, 407')
			await C.HumanNPC2.say('¿ya te has cansado de apretar el botón?')
			
			var response: PopochiuDialogOption = await D.show_inline_dialog(
				'¿Qué debería hacer?',
				[
					'Rendirme, soy quien lleva más tiempo en el laboratorio', 'Necesito escapar, ¿puedes ayudarme?'
				]
			)
			
			match response.id:
				'0':
					await C.Human.say('Si mi destino es estar aquí')
					await C.Human.say('no importa lo que haga, o cuantas veces apriete el botón')
					await C.Human.say('solo seguirá todo igual')
					Globals.dialog_ended.emit()
					
				'1':
					await C.HumanNPC2.say('Como dije, todo es cuestión de perspectivas 407')
					await C.HumanNPC2.say('Te aconsejo usar tu libertad')
					await C.HumanNPC2.say('para discernir de las ordenes que te quieren dar')
					await C.HumanNPC2.say('solo así podrás ver ante ti los distintos matices que la vida tiene.')
					Globals.dialog_ended.emit()
		
		2:
			await C.HumanNPC2.say('Ya sabes qué hacer 407.')
			Globals.dialog_ended.emit()


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
	hand_raised = false
	anim_player.play("walk")
	super(target_pos)


func _walk_ended() -> void:
	emit_signal('npc_arrived')
	
	var probability := randi() %100
	if probability <= 50:
		hand_raised = true
		_play_hand()
	else:
		hand_raised = false
		_play_idle()


# Use it to play the talk animation for the character
func _play_talk() -> void:
	super()


# Use it to play the grab animation for the character
func _play_grab() -> void:
	super()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PUBLIC ░░░░
func play(anim_name: String) -> void:
	pass
