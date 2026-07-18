extends CanvasLayer

@onready var roll_button: Button = $BottomBar/RollButton

func _ready() -> void:
	roll_button.pressed.connect(_on_roll_pressed)
	DiceManager.roll_finished.connect(_on_roll_finished)

func _on_roll_pressed() -> void:
	DiceManager.roll()

func _on_roll_finished(value: int) -> void:
	print("Player rolled ", value)
