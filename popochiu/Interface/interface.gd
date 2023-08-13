extends CanvasLayer

@onready var btn_start: Button = $Intro/start
@onready var dialog_menu_title: Label = $Dialogs/Dialog_title
@onready var dialog_menu: PanelContainer = $Dialogs/DialogMenu
@onready var rtl_dialog: RichTextLabel = $Dialogs/RtlDialog
@onready var rtl_narrator: RichTextLabel = $Dialogs/RtlNarrador

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	dialog_menu_title.text = ""
	dialog_menu_title.set_meta('ori_y', dialog_menu_title.position.y)
	Globals.intro_triggered.connect(_on_intro_triggered)
	G.title_setted.connect(_set_dialog_menu_title)
	C.character_spoke.connect(_show_character_text)
	dialog_menu.selected.connect(_on_selected)


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


func _show_character_text(c: PopochiuCharacter, m: String) -> void:
	var text := '[center]%s[/center]'
	
	match c:
		C.Narrator:
			rtl_dialog.text = ''
			rtl_narrator.text = text % m
		_:
			rtl_narrator.text = ''
			rtl_dialog.text = text % ('%s: %s' % [c.description, m])
