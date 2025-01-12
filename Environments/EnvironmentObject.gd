class_name EnvironmentObject

extends Area2D

var collision = []

func change_opacity(player, collision):
	if player in collision:
		while get_node("../Sprite2D").modulate.a > 0.3:
			get_node("../Sprite2D").modulate.a -= 0.1
			await get_tree().create_timer(0.1).timeout
	else:
		while get_node("../Sprite2D").modulate.a < 1:
			get_node("../Sprite2D").modulate.a += 0.1
			await get_tree().create_timer(0.1).timeout

func _on_body_entered(area: Node2D) -> void:
	collision.append(area)

func _on_body_exited(area: Node2D) -> void:
	collision.erase(area)
