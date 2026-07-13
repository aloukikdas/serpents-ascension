# Tile.gd: Represents a single space on the board. Stores data, not logic.
class_name Tile
extends Node2D

@export var tile_id: int = 0
@export var world_position: Vector2 = Vector2.ZERO
@export var is_snake: bool = false
@export var is_ladder: bool = false
@export var occupied_players: Array = []
