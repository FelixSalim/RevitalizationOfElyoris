extends Area2D

# Get players
@onready var player = get_node("../../Environments/Player/Player")
@onready var playerCam = player.get_node("Camera2D")

# When player enter move back to overworld
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.global_position = Settings.GlobalPositions["World"]
		playerCam.limit_left = Settings.LoadingZones["World"]["Left"]
		playerCam.limit_bottom = Settings.LoadingZones["World"]["Bottom"]
		playerCam.limit_right = Settings.LoadingZones["World"]["Right"]
		playerCam.limit_top = Settings.LoadingZones["World"]["Top"]
