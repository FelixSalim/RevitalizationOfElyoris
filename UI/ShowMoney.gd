extends Node

# Update money
func _process(delta):
	self.text = "Money : " + str(Game.money)
