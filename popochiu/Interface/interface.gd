extends CanvasLayer

@onready var btn_start: Button = $Intro/start
@onready var dialog_menu_title: Label = $Dialogs/Dialog_title
@onready var dialog_menu: PanelContainer = $Dialogs/DialogMenu
@onready var rtl_dialog: RichTextLabel = $Dialogs/RtlDialog
@onready var rtl_narrator: RichTextLabel = $Dialogs/RtlNarrador
@onready var btn_continue: TextureButton = $Dialogs/BtnContinue
@onready var bg_dialog_room: Control = $Dialogs/Dialog_room
@onready var timer : TextureProgressBar = $Dialogs/Timer
@onready var end_game :CanvasLayer = $End_game
@onready var end_true = end_game.get_node("End")
@onready var end_false = end_game.get_node("Again")

var counting := false
var tween : Tween
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	timer.hide()
	end_game.hide()
	bg_dialog_room.hide()
	dialog_menu_title.text = ""
	dialog_menu_title.set_meta('ori_y', dialog_menu_title.position.y)
	Globals.intro_triggered.connect(_on_intro_triggered)
	Globals.dialog_ended.connect(_on_dialog_ended)
	C.character_spoke.connect(_show_character_text)
	Globals.tween_initial.connect(on_tween_initial)
	Globals.reward.connect(on_reward)
	Globals.end_game.connect(on_end_game)
	G.title_setted.connect(_set_dialog_menu_title)
	dialog_menu.selected.connect(_on_selected)
	btn_continue.pressed.connect(_on_continue_pressed)


func _on_intro_triggered() -> void:
	btn_start.pressed.connect(_button_pressed)
	$Intro.show()


func _button_pressed() -> void:
	btn_start.pressed.disconnect(self._button_pressed)
	E.goto_room('Room_Lab', false)
	$Intro.hide()


func _set_dialog_menu_title(title := '') -> void:
	rtl_dialog.text = ''
	rtl_narrator.text = ''
	if title.is_empty():
		dialog_menu_title.text = ''
		return
	
	var panel_size = await dialog_menu.panel_resized
	var position = dialog_menu_title.get_meta('ori_y')
	dialog_menu_title.text = title
	dialog_menu_title.position.y = position - panel_size.y


func _on_selected() -> void:
	dialog_menu_title.text = ""
	rtl_dialog.text = ''
	rtl_narrator.text = ''
	_on_continue_pressed()


func _on_dialog_ended() -> void:
	Globals.in_dialog = false
	Globals.audio.emit('play', 'MX', 'Ambient')
	bg_dialog_room.hide()
	if counting:
		tween.play()
		timer.show()


func _show_character_text(c: PopochiuCharacter, m: String) -> void:
	Globals.in_dialog = true
	Globals.audio.emit('stop', 'MX', 'Steps')
	var text := '[center]%s[/center]'
	match c:
		C.Narra:
			rtl_dialog.text = ''
			rtl_narrator.text = text % m
		_:
			Globals.audio.emit('stop', 'MX', 'Ambient')
			bg_dialog_room.show()
			rtl_narrator.text = ''
			rtl_dialog.text = text % ('%s: %s' % [c.description, m])
			if not tween == null:
				tween.pause()
			timer.hide()
	
	btn_continue.show()


func _on_continue_pressed() -> void:
	rtl_dialog.text = ''
	rtl_narrator.text = ''
	btn_continue.hide()
	G.continue_clicked.emit()


func start_timer() -> void:
	tween = create_tween()
	timer.value = 100
	tween.tween_property(timer, 'value', 0, 20).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	timer.show()
	counting = true
	await tween.finished
	Globals.tween_ended.emit()
	timer.hide()
	counting = false


func on_tween_initial() -> void:
	start_timer()


func on_reward() -> void:
	var cpu_src = load("res://popochiu/Interface/coins.tscn") as PackedScene
	var cpu_coins = cpu_src.instantiate()
	cpu_coins.emitting = true
	$Dialogs/Marker2D.add_child(cpu_coins)
	
	if counting:
		tween.kill()
		counting = false
		tween = create_tween()
		tween.tween_property(timer, 'value', 100, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		await tween.finished
		Globals.abort_tween.emit()
		timer.hide()
	
	await get_tree().create_timer(4.0).timeout
	$Dialogs/Marker2D.remove_child(cpu_coins)
	cpu_coins.queue_free()


func on_end_game() -> void:
	tween.kill()
	counting = false
	tween = create_tween()
	timer.hide()
	end_true.pressed.connect(on_end_true)
	end_false.pressed.connect(on_end_false)
	end_game.show()


func on_end_true() -> void:
	end_true.pressed.disconnect(on_end_true)
	end_false.pressed.disconnect(on_end_false)
	get_tree().quit()


func on_end_false() -> void:
	end_true.pressed.disconnect(on_end_true)
	end_false.pressed.disconnect(on_end_false)
	end_game.hide()
	Globals.restart_game.emit()
	tween = create_tween()
