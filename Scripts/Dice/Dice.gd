class_name Dice
extends Node2D

signal animation_finished

@onready var roll_label: Label = $RollLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Automatically update visuals when a roll finishes
	DiceManager.roll_finished.connect(show_value)

func show_value(value: int) -> void:
	roll_label.text = str(value)
	play_roll_animation()

func play_roll_animation() -> void:
	if animation_player.has_animation("roll"):
		animation_player.play("roll")
