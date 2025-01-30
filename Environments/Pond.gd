extends StaticBody2D

# Stores colliding objects
# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
var collision = []

func _process(delta: float) -> void:
	if collision.size() > 0:
		enter()

func enter():
	# Stores player
	var player = get_node("../Environments/Player/Player")
	# If player is colliding and pressed interact, pop notification
	if player.get_node("InteractBox") in collision and Input.is_action_just_pressed("ui_accept") and player.interactingState.name == "water" and player.get_node("Control/UI/InventoryBar/Slots").get_child(Game.selected).get_child(2).water <= 90:
		# When player tiles the land, change player to idle (stop player from moving)
		player.change_moving_state("idle")
		
		# Play the corresponding animation
		if player.lastDir == "left":
			player.get_node("AnimationPlayer").play("WaterLeft")
		if player.lastDir == "right":
			player.get_node("AnimationPlayer").play("WaterRight")
		if player.lastDir == "down":
			player.get_node("AnimationPlayer").play("WaterDown")
		if player.lastDir == "up":
			player.get_node("AnimationPlayer").play("WaterUp")
			
		player.get_node("Control/UI/InventoryBar/Slots").get_child(Game.selected).get_child(2).water = 100

	
# When a collision occurs, add the collision to the array
func _on_area_2d_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_2d_area_exited(area: Area2D) -> void:
	collision.erase(area)
