extends Node2D

# When button is pressed
func _on_touch_screen_button_pressed():
	# Navigate to "World" Scene
	get_tree().change_scene_to_file("res://Areas/World.tscn")
	Utils.save_game()
	
	# Load save
	Utils.load_game()


func _on_touch_screen_button_2_pressed() -> void:
	# Navigate to "World" Scene
	get_tree().change_scene_to_file("res://Areas/World.tscn")
	
	# Load save
	Utils.load_game()


func _on_touch_screen_button_3_pressed() -> void:
	# Exit game
	get_tree().quit()
