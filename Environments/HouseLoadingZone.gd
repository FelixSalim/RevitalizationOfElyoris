extends Area2D

# Stores player
@onready var player = get_node("../../Environments/Player/Player")
@onready var playerCam = player.get_node("Camera2D")

# Stores colliding area
var collisions = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
# When collision is detected wait for user input
func _process(delta: float) -> void:
	if len(collisions) > 0:
		enter_zone()

# If player pressed accept then enter the zone
func enter_zone():
	if Input.is_action_just_pressed("ui_accept") and player.get_node("InteractBox") in collisions:
		player.global_position = Settings.GlobalPositions["House"]
		playerCam.limit_left = Settings.LoadingZones["House"]["Left"]
		playerCam.limit_bottom = Settings.LoadingZones["House"]["Bottom"]
		playerCam.limit_right = Settings.LoadingZones["House"]["Right"]
		playerCam.limit_top = Settings.LoadingZones["House"]["Top"]

# Adds the area to collision when colliding
func _on_area_entered(area: Area2D) -> void:
	collisions.append(area)

# Removes the area from collision when not colliding
func _on_area_exited(area: Area2D) -> void:
	collisions.erase(area)
