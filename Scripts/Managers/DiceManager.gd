extends Node

signal roll_started
signal roll_finished(value: int)

const MIN_VALUE := 1
const MAX_VALUE := 6

var rng := RandomNumberGenerator.new()
var current_roll: int = 1
var is_rolling := false
var roll_history: Array[int] = []

func _ready() -> void:
	rng.randomize()

func roll() -> void:
	if is_rolling:
		return

	is_rolling = true
	roll_started.emit()

	current_roll = rng.randi_range(MIN_VALUE, MAX_VALUE)
	roll_history.append(current_roll)
	
	roll_finished.emit(current_roll)
	is_rolling = false

func get_last_roll() -> int:
	return current_roll

func reset() -> void:
	current_roll = 1
	roll_history.clear()
