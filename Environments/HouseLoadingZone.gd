extends Area2D

# Stores player
@onready var player = get_node("../../Player/Player")

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
		player.global_position = Vector2(7936, -1531)

# Adds the area to collision when colliding
func _on_area_entered(area: Area2D) -> void:
	collisions.append(area)

# Removes the area from collision when not colliding
func _on_area_exited(area: Area2D) -> void:
	collisions.erase(area)
