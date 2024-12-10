extends InteractingState

# Declares a class
class_name SeedState

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if player.get_node("InteractBox") in collision and tileState == "Watered":
		if Input.is_action_pressed("ui_accept"):
			if player.lastDir == "left":
				playerAnimation.play("SeedLeft")
			if player.lastDir == "right":
				playerAnimation.play("SeedRight")
			if player.lastDir == "down":
				playerAnimation.play("SeedDown")
			if player.lastDir == "up":
				playerAnimation.play("SeedUp")
			tile.tileState = "Planted"
