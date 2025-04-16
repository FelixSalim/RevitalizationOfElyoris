extends InteractingState

# Declares a class
class_name TillState

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if player.get_node("InteractBox") in collision and tileState == "Tillable":
		if Input.is_action_pressed("ui_accept"):
			# When player tiles the land, change player to idle (stop player from moving)
			player.change_moving_state("idle")
			
			# Play the corresponding animation
			if player.lastDir == "left":
				playerAnimation.play("TillLeft")
			if player.lastDir == "right":
				playerAnimation.play("TillRight")
			if player.lastDir == "down":
				playerAnimation.play("TillDown")
			if player.lastDir == "up":
				playerAnimation.play("TillUp")
			
			# Change the state of tile
			tile.tileState = "Tilled"
			player.get_node("AudioStreamPlayer").stream = load("res://Assets/Audio/tilling-land.mp3")
			player.get_node("AudioStreamPlayer").play()
