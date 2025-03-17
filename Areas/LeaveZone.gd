extends Area2D

# Get players
@onready var player = get_node("../Environments/Player/Player")
@onready var playerCam = player.get_node("Camera2D")

# Export ending location
@export var loc: String

# When player enter move back to overworld
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		var playerAnimation = player.get_node("AnimationPlayer")
		
		# Hides player UI
		player.get_node("Control/UI").hide()
		
		# Prevent player from moving
		player.change_moving_state("idle")
		player.isInteracting = true
		
		# Stop player animation
		playerAnimation.stop()
		
		# Play fade in animation
		playerAnimation.play("Fade In")
		
		# Wait for 1 seconds
		await get_tree().create_timer(1).timeout
		
		player.global_position = Settings.GlobalPositions[loc]
		playerCam.limit_left = Settings.LoadingZones[loc]["Left"]
		playerCam.limit_bottom = Settings.LoadingZones[loc]["Bottom"]
		playerCam.limit_right = Settings.LoadingZones[loc]["Right"]
		playerCam.limit_top = Settings.LoadingZones[loc]["Top"]
		
		await get_tree().create_timer(0.4).timeout
		
		# Play fade out animation
		playerAnimation.play("Fade Out")
		
		# Wait for 0.6 seconds
		await get_tree().create_timer(0.6).timeout
		
		# Show player UI again
		player.get_node("Control/UI").show()
		
		# Enables movement
		player.isInteracting = false
			
