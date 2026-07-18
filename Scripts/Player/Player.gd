class_name Player
extends Node2D

# --------------------------------------------------
# Signals
# --------------------------------------------------
signal tile_changed(new_tile: int)
signal movement_finished
signal state_changed(new_state: PlayerState)

# --------------------------------------------------
# State Machine
# --------------------------------------------------
enum PlayerState {
	IDLE,
	WAITING,
	MOVING,
	ANIMATING,
	WINNER
}

var state: PlayerState = PlayerState.IDLE

# --------------------------------------------------
# Identity
# --------------------------------------------------
@export var player_id: int = 1
@export var player_name: String = "Player"
@export var is_ai: bool = false

# --------------------------------------------------
# Gameplay
# --------------------------------------------------
var current_tile: int = 1
var previous_tile: int = 1
var total_rolls: int = 0
var snakes_hit: int = 0
var ladders_climbed: int = 0
var wins: int = 0

# --------------------------------------------------
# References
# --------------------------------------------------
@onready var character: Sprite2D = $Character
@onready var shadow: Sprite2D = $Shadow
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spawn_particles: GPUParticles2D = $SpawnParticles
@onready var name_label: Label = $NameLabel
@onready var state_label: Label = $StateLabel

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
