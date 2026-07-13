# Board.gd: Manages the generation and state of the grid and its tiles.
class_name Board
extends Node2D

func generate_board() -> void:
	pass

func get_tile(id: int) -> Node2D:
	return null

func highlight_tile(id: int) -> void:
	pass

func reset_highlights() -> void:
	pass
