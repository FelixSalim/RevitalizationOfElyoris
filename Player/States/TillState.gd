extends InteractingState

class_name TillState

func interact(tile, tileState, collision):
	if tileState == "Tillable":
		if Input.is_action_pressed("ui_accept"):
			tile.tileState = "Tilled"
