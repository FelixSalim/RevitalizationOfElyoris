extends StaticBody2D

# Loads zone to enter the house
@onready var enterZone = $EnterZone

# Stores colliding area
var collisions = []

# Called every frame. 'delta' is the elapsed time since the previous frame.
# When collision is detected wait for user input
func _process(delta: float) -> void:
	if len(collisions) > 0:
		enter_zone()

# If player pressed accept then enter the zone
func enter_zone():
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Areas/Home.tscn")	

# Adds the area to collision when colliding
func _on_enter_zone_area_entered(area: Area2D) -> void:
	collisions.append(area)

# Removes the area from collision when not colliding
func _on_enter_zone_area_exited(area: Area2D) -> void:
	collisions.erase(area)
