extends Area2D

# Get players
@onready var player = get_node("../Environments/Player/Player")
@onready var playerCam = player.get_node("Camera2D")

# Export ending location
@export var loc: String

# When player enter move back to overworld
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.global_position = Settings.GlobalPositions[loc]
		playerCam.limit_left = Settings.LoadingZones[loc]["Left"]
		playerCam.limit_bottom = Settings.LoadingZones[loc]["Bottom"]
		playerCam.limit_right = Settings.LoadingZones[loc]["Right"]
		playerCam.limit_top = Settings.LoadingZones[loc]["Top"]
