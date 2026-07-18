extends Node

var players: Array[Player] = []
var player_scene: PackedScene = preload("res://Scenes/Player/Player.tscn")

func _ready() -> void:
	# For testing purposes, we spawn when the manager loads.
	# Later, GameManager will call this after Board finishes generating.
	call_deferred("spawn_players")

func spawn_players() -> void:
	spawn_player(1, "Player 1", false)

func spawn_player(id: int, p_name: String, is_ai: bool) -> void:
	if player_scene == null:
		push_error("Player Scene not found.")
		return
		
	var player_instance = player_scene.instantiate() as Player
	
	# Find the board and the players container in the current scene tree
	var board = get_tree().current_scene.get_node_or_null("Board")
	if board:
		var players_container = board.get_node("Players")
		players_container.add_child(player_instance)
		
		# Setup data
		player_instance.initialize(id, p_name, is_ai)
		
		# Position via PieceAnchor
		var start_tile = board.get_tile(1)
		if start_tile and start_tile.piece_anchor:
			player_instance.global_position = start_tile.piece_anchor.global_position
			
		players.append(player_instance)
		
		# Record the spawn event
		if ReplayManager:
			ReplayManager.record_event("player_spawned", {"player_id": id, "tile": 1})

func remove_player(id: int) -> void:
	pass

func get_player(id: int) -> Player:
	for p in players:
		if p.player_id == id:
			return p
	return null

func get_current_player() -> Player:
	return players[0] if players.size() > 0 else null

func reset_players() -> void:
	for p in players:
		p.queue_free()
	players.clear()
