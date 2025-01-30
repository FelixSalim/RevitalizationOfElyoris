extends Node2D

# When button is pressed
func _on_touch_screen_button_pressed():
	# Navigate to "World" Scene
	get_tree().change_scene_to_file("res://Areas/World.tscn")
	Utils.load_game()
