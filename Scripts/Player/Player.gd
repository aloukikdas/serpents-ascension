class_name Player
extends Node2D

# --------------------------------------------------
# Signals
# --------------------------------------------------
signal movement_started
signal tile_entered(tile_id: int)
signal tile_left(tile_id: int)
signal movement_finished(final_tile: int)
signal state_changed(new_state: PlayerState)

# --------------------------------------------------
# State Machine
# --------------------------------------------------
enum PlayerState {
	IDLE,
	ROLLING,
	MOVING,
	SNAKE,
	LADDER,
	WINNING
}

var state: PlayerState = PlayerState.IDLE

# --------------------------------------------------
# Identity
# --------------------------------------------------
@export var player_id: int = 1
@export var player_name: String = "Player"
@export var is_ai: bool = false

# --------------------------------------------------
# Gameplay & Statistics
# --------------------------------------------------
var current_tile: int = 1
var previous_tile: int = 1

var statistics: Dictionary = {
	"tiles_walked": 0,
	"snakes_hit": 0,
	"ladders_used": 0,
	"games_played": 0,
	"highest_roll": 0
}

# --------------------------------------------------
# References
# --------------------------------------------------
@onready var character: Sprite2D = $Character
@onready var shadow: Sprite2D = $Shadow
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spawn_particles: GPUParticles2D = $SpawnParticles
@onready var name_label: Label = $NameLabel
@onready var state_label: Label = $StateLabel
@onready var footstep_audio: AudioStreamPlayer = $FootStepAudio

# --------------------------------------------------
# Engine
# --------------------------------------------------
func _ready() -> void:
	name_label.text = player_name
	state_label.text = ""

# --------------------------------------------------
# Public API
# --------------------------------------------------
func initialize(id: int, p_name: String, ai: bool = false) -> void:
	player_id = id
	player_name = p_name
	is_ai = ai
	name_label.text = player_name

func move_steps(steps: int) -> void:
	MovementController.move_player(self, steps)

func move_to_tile(tile_id: int) -> void:
	pass

func teleport_to_tile(tile_id: int) -> void:
	pass

func play_idle() -> void:
	pass

func celebrate() -> void:
	pass

func defeat() -> void:
	pass

func reset_player() -> void:
	pass
