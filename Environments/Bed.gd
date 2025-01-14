extends Sprite2D


# Stores any object colliding this tile
var collisions = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
# When collision is detected wait for user input
func _process(delta: float) -> void:
	if len(collisions) > 0:
		enter_sleep()

func enter_sleep():
	# Stores player
	var player = get_node("../../Environments/Player/Player")
	
	# If player interact then go to sleep
	if Input.is_action_just_pressed("ui_accept") and player.get_node("InteractBox") in collisions and not player.isInteracting:
		player.sleep(false)

# Adds the area to collision when colliding
func _on_area_2d_area_entered(area: Area2D) -> void:
	collisions.append(area)

# Removes the area from collision when not colliding
func _on_area_2d_area_exited(area: Area2D) -> void:
	collisions.erase(area)
