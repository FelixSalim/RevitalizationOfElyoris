extends InteractingState

# Declares a class
class_name TillState

# When player interact with the land, tile the land
func interact(tile, tileState, collision):
	if get_parent().get_parent().get_node("InteractBox") in collision and tileState == "Tillable":
		if Input.is_action_pressed("ui_accept"):
			tile.tileState = "Tilled"
