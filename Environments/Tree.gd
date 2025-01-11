extends Area2D	

# Stores colliding objects
var collision = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
# If player interaction is colliding, show notification
func _process(delta: float) -> void:
	if collision.size() >= 0:
		enter()

func enter():
	# Stores player
	var player = get_node("../../Player/Player")
	# If player is colliding and pressed interact, pop notification
	if player in collision:
		while get_node("../Sprite2D").modulate.a > 0.3:
			get_node("../Sprite2D").modulate.a -= 0.1
			await get_tree().create_timer(0.1).timeout
	else:
		print("a")
		while get_node("../Sprite2D").modulate.a < 1:
			get_node("../Sprite2D").modulate.a += 0.1
			await get_tree().create_timer(0.1).timeout

# When a collision occurs, add the collision to the array
func _on_body_entered(area: Node2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_body_exited(area: Node2D) -> void:
	collision.erase(area)
