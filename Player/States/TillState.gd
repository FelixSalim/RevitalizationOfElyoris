extends InteractingState

# Declares a class
class_name TillState

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if player.get_node("InteractBox") in collision and tileState == "Tillable":
		if Input.is_action_pressed("ui_accept"):
			if player.lastDir == "left":
				playerAnimation.play("TillLeft")
			if player.lastDir == "right":
				playerAnimation.play("TillRight")
			if player.lastDir == "down":
				playerAnimation.play("TillDown")
			if player.lastDir == "up":
				playerAnimation.play("TillUp")
			
			#await playerAnimation.animation_finished 
			tile.tileState = "Tilled"
			
