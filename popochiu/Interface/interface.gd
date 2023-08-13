extends CanvasLayer

@onready var btn_start: Button = $Intro/start
@onready var dialog_menu_title: Label = $Dialogs/Dialog_title
@onready var dialog_menu: PanelContainer = $Dialogs/DialogMenu
@onready var rtl_dialog: RichTextLabel = $Dialogs/RtlDialog
@onready var rtl_narrator: RichTextLabel = $Dialogs/RtlNarrador
@onready var btn_continue: TextureButton = $Dialogs/BtnContinue
@onready var bg_dialog_room: Control = $Dialogs/Dialog_room
@onready var timer : TextureProgressBar = $Dialogs/Timer

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	timer.hide()
	bg_dialog_room.hide()
	dialog_menu_title.text = ""
	dialog_menu_title.set_meta('ori_y', dialog_menu_title.position.y)
	Globals.intro_triggered.connect(_on_intro_triggered)
	Globals.dialog_ended.connect(_on_dialog_ended)
	Globals.tween_initial.connect(on_tween_initial)
	G.title_setted.connect(_set_dialog_menu_title)
	C.character_spoke.connect(_show_character_text)
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
	bg_dialog_room.hide()


func _show_character_text(c: PopochiuCharacter, m: String) -> void:
	var text := '[center]%s[/center]'
	match c:
		C.Narra:
			rtl_dialog.text = ''
			rtl_narrator.text = text % m
		_:
			bg_dialog_room.show()
			rtl_narrator.text = ''
			rtl_dialog.text = text % ('%s: %s' % [c.description, m])
	
	btn_continue.show()


func _on_continue_pressed() -> void:
	rtl_dialog.text = ''
	rtl_narrator.text = ''
	btn_continue.hide()
	G.continue_clicked.emit()


func start_timer() -> void:
	var tween = create_tween()
	tween.tween_property(timer, 'value', 0, 20).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	timer.show()
	await tween.finished
	Globals.tween_ended.emit()
	timer.hide()


func on_tween_initial() -> void:
	start_timer()
