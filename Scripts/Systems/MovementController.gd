extends Node

func move_player(player: Player, steps: int) -> void:
	# Prevent multiple movement calls if already moving
	if player.state == player.PlayerState.MOVING:
		return
		
	player.state = player.PlayerState.MOVING
	player.movement_started.emit()
	
	# Get board reference safely
	var board = get_tree().current_scene.get_node_or_null("Board")
	if not board:
		push_error("MovementController: Board not found!")
		player.state = player.PlayerState.IDLE
		return
		
	for i in range(steps):
		var next_tile_id = player.current_tile + 1
		
		# Prevent moving past the final tile (100)
		if next_tile_id > 100:
			break 
			
		var next_tile = board.get_tile(next_tile_id)
		if not next_tile:
			break
			
		player.tile_left.emit(player.current_tile)
		
		# Create the Tween for smooth movement
		var tween = create_tween()
		
		# Move the player's global position
		tween.tween_property(player, "global_position", next_tile.piece_anchor.global_position, 0.18)
		
		# Apply the exact 3-step squash and stretch animation
		tween.parallel().tween_property(player.character, "scale", Vector2(0.93, 0.93), 0.06)
		tween.chain().tween_property(player.character, "scale", Vector2(1.02, 1.02), 0.06)
		tween.chain().tween_property(player.character, "scale", Vector2(1.0, 1.0), 0.06)
		
		# Wait for this single step to finish before continuing the loop
		await tween.finished
		
		# Play the footstep audio if the node exists
		if player.footstep_audio:
			player.footstep_audio.play()
		
		# Update player data and statistics
		player.current_tile = next_tile_id
		player.statistics["tiles_walked"] += 1
		player.tile_entered.emit(next_tile_id)
		
		# Trigger any events on the tile (like future Snakes or Ladders)
		next_tile.on_player_enter(player)
		
	# Finish movement
	player.state = player.PlayerState.IDLE
	player.movement_finished.emit(player.current_tile)
