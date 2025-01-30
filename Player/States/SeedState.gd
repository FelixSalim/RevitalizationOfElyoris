extends InteractingState

# Declares a class
class_name SeedState

# Declares plants
const turnip = preload("res://Plants/TurnipPlant.tscn")

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if player.get_node("InteractBox") in collision and tileState == "Tilled":
		if Input.is_action_pressed("ui_accept"):
			# When player tiles the land, change player to idle (stop player from moving)
			player.change_moving_state("idle")
			
			# Play the corresponding animation
			if player.lastDir == "left":
				playerAnimation.play("SeedLeft")
			if player.lastDir == "right":
				playerAnimation.play("SeedRight")
			if player.lastDir == "down":
				playerAnimation.play("SeedDown")
			if player.lastDir == "up":
				playerAnimation.play("SeedUp")
				
			# Change the state of tile	
			tile.tileState = "Planted"
			
			# Spawn the seed
			var plant
			if ItemData.item[Game.inventory[Game.selected]]["Name"] == "TurnipSeed":
				plant = turnip.instantiate()
			
			tile.add_child(plant)
			
