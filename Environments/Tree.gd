extends EnvironmentObject

# Stores colliding objects
# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() >= 0:
		enter()

func enter():
	# Stores player
	var player = get_node("../../Player/Player")
	# If player is colliding and pressed interact, pop notification
	change_opacity(player, collision)
