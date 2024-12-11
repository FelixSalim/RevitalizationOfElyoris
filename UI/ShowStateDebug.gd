extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Change the text to current state
func _process(delta: float) -> void:
	self.text = "State : " + Game.currentInteractingState
