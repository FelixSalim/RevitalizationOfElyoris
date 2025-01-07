extends Area2D

# Get players
@onready var player = get_node("../../Player/Player")
@onready var playerCam = player.get_node("Camera2D")

# When player enter move back to overworld
func _on_body_entered(body: Node2D) -> void:
	if body == player:
		player.global_position = Vector2(1116.419, 667.009)
		playerCam.limit_left = 0
		playerCam.limit_bottom = 1167
		playerCam.limit_right = 2489
		playerCam.limit_top = 0
