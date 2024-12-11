extends InteractingState

# Declares a class
class_name WaterState

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if player.get_node("InteractBox") in collision and tileState == "Tilled":
		if Input.is_action_pressed("ui_accept"):
			# When player tiles the land, stop all animation and change player to idle
			playerAnimation.stop()
			player.change_moving_state("idle")
			
			# Play the corresponding animation
			if player.lastDir == "left":
				playerAnimation.play("WaterLeft")
			if player.lastDir == "right":
				playerAnimation.play("WaterRight")
			if player.lastDir == "down":
				playerAnimation.play("WaterDown")
			if player.lastDir == "up":
				playerAnimation.play("WaterUp")
				
			# Change the state of tile
			tile.tileState = "Watered"
