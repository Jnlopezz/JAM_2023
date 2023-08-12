extends CanvasLayer

@onready var btn_start: Button = $Intro/start

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	Globals.intro_triggered.connect(_on_intro_triggered)


func _on_intro_triggered() -> void:
	btn_start.pressed.connect(self._button_pressed)
	$Intro.show()


func _button_pressed() -> void:
	btn_start.pressed.disconnect(self._button_pressed)
	E.goto_room('Room_Lab', false)
	$Intro.hide()
