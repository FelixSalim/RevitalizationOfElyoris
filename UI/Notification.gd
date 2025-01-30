extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Every frame adjust size of panel to fit the text
func _process(delta: float) -> void:
	#get_node("Panel").size.x = get_node("Panel/Label").size.x
	if get_node("Panel").size.y < get_node("Panel/Label").size.y/2:
		get_node("Panel").size.y = get_node("Panel/Label").size.y/2

# Set the text that will appear
func set_notification(notification):
	get_node("Panel/Label").text = notification
