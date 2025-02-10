extends InteractingState

# Declares a class
class_name WaterState

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if player.get_node("InteractBox") in collision and tileState != "Tillable" and not tile.isWatered and player.get_node("Control/UI/InventoryBar/Slots").get_child(Game.selected).get_child(2).water >= 10:
		if Input.is_action_pressed("ui_accept"):
			# When player tiles the land, change player to idle (stop player from moving)
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
				
			player.get_node("Control/UI/InventoryBar/Slots").get_child(Game.selected).get_child(2).water -= 10
			
			# Change the state of tile
			tile.isWatered = true
