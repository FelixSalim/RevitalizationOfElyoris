extends EnvironmentObject

# Stores colliding objects
# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()

func enter():
	# Stores player
	var player = get_node("../../Player/Player")
	change_opacity(player, collision)
	# If player is colliding and pressed interact, pop notification
	if player.get_node("InteractBox") in collision and Input.is_action_just_pressed("ui_accept") and player.movementState.name != "notify":
		player.change_moving_state("notify")
		player.get_node("Control/UI/Notification").set_notification("No mail for todayawait get_tree().create_timer(time_in_seconds).timeoutawait get_tree().create_timer(time_in_seconds).timeoutawait get_tree().create_timer(time_in_seconds).timeoutawait get_tree().create_timer(time_in_seconds).timeoutawait get_tree().create_timer(time_in_seconds).timeoutawait get_tree().create_timer(time_in_seconds).timeout")

	
# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)
	
# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
