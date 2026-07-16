class_name Tile
extends Node2D

@export var tile_id: int = 0
@export var board_position: Vector2i
@export var is_snake: bool = false
@export var is_ladder: bool = false

var occupied_players: Array[Node] = []

@onready var tile_number: Label = $Visual/TileNumber
@onready var piece_anchor: Marker2D = $PieceAnchor

func setup(id: int, grid_position: Vector2i) -> void:
	tile_id = id
	board_position = grid_position
	tile_number.text = str(id)
