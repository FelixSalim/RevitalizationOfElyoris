extends Area2D

# Stores colliding objects
var collision = []


# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()

func enter():
	# Stores player
	var player = get_parent().get_node("Player")
	# If player is colliding and pressed interact, pop notification
	if player.get_node("InteractBox") in collision and Input.is_action_just_pressed("ui_accept") and player.movementState.name != "notify":
		player.change_moving_state("notify")
		get_parent().get_node("Player/Control/UI/Notification").set_notification("Hi, this is a mailbox")

# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
