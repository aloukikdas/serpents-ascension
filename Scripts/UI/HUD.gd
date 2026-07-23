extends CanvasLayer

@onready var roll_button: Button = $BottomBar/RollButton

func _ready() -> void:
	roll_button.pressed.connect(_on_roll_pressed)
	DiceManager.roll_finished.connect(_on_roll_finished)

func _on_roll_pressed() -> void:
	roll_button.disabled = true
	DiceManager.roll()

func _on_roll_finished(value: int) -> void:
	print("Player rolled ", value)
	
	var player = PlayerManager.get_current_player()
	if player:
		# We dynamically connect the signal here, ensuring the player exists!
		if not player.movement_finished.is_connected(_on_movement_finished):
			player.movement_finished.connect(_on_movement_finished)
			
		if value > player.statistics["highest_roll"]:
			player.statistics["highest_roll"] = value
			
		# Trigger the movement!
		player.move_steps(value)
	else:
		# Safety fallback: re-enable button if no player is found
		roll_button.disabled = false

func _on_movement_finished(final_tile: int) -> void:
	# Re-enable the button once the player has stopped moving
	roll_button.disabled = false
