extends StaticBody2D

# Stores collision
var collision = []

func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()

func enter():
	# Stores player
	var player = get_node("../Environments/Player/Player")
	# If player is colliding and pressed interact, pop notification and put item in box
	if player.get_node("InteractBox") in collision and Input.is_action_just_pressed("ui_accept") and (player.movementState.name != "notify") and Game.inventory[Game.selected] >= 100:
		var item = ItemData.harvest[Game.inventory[Game.selected] - 100]
		player.change_moving_state("notify")
		player.movementState.initialize("store")
		player.get_node("Control/UI/Notification").set_notification("You stored a " + item["Name"] + " in the shipping box" )
		
	
# When a collision occurs, add the collision to the array
func _on_area_2d_area_entered(area: Area2D) -> void:
	collision.append(area)
	
# When a collision no longer exists, remove the collision from the array
func _on_area_2d_area_exited(area: Area2D) -> void:
	collision.erase(area)
