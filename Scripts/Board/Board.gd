class_name Board
extends Node2D

# ----------------------------------------------------
# Board Configuration
# ----------------------------------------------------
@export var rows: int = 10
@export var columns: int = 10
@export var tile_size: Vector2 = Vector2(96, 96)
@export var tile_spacing: int = 6

@export var tile_scene: PackedScene

# ----------------------------------------------------
# References
# ----------------------------------------------------
@onready var tiles_container: Node2D = $Tiles

# ----------------------------------------------------
# Data (Optimized for both Lookup and Iteration)
# ----------------------------------------------------
var tile_lookup: Dictionary = {}
var tile_list: Array[Tile] = []

# ----------------------------------------------------
# Engine
# ----------------------------------------------------
func _ready() -> void:
	generate_board()

# ----------------------------------------------------
# Public API
# ----------------------------------------------------
func get_tile(id: int) -> Tile:
	return tile_lookup.get(id)

func highlight_tile(id: int) -> void:
	pass

func reset_highlights() -> void:
	pass

# ----------------------------------------------------
# Procedural Generation
# ----------------------------------------------------
func generate_board() -> void:
	if tile_scene == null:
		push_error("Tile Scene not assigned.")
		return

	var current_tile := 1

	for row in range(rows):
		# If row is odd (1, 3, 5...), we reverse the column order
		var reverse := row % 2 == 1

		for column in range(columns):
			var actual_column := column

			if reverse:
				actual_column = columns - 1 - column

			var tile: Tile = tile_scene.instantiate()
			tiles_container.add_child(tile)

			# Calculate physical world position
			var x := actual_column * (tile_size.x + tile_spacing)
			var y := (rows - 1 - row) * (tile_size.y + tile_spacing)

			tile.position = Vector2(x, y)
			
			# Inject the data into the tile
			tile.setup(current_tile, Vector2i(actual_column, row))

			# Store references in both data structures
			tile_lookup[current_tile] = tile
			tile_list.append(tile)

			current_tile += 1
