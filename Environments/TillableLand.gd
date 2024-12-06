extends Area2D

# Declares class
class_name TillableLand

# Gets player state onready
@onready var interactingState = get_parent().get_node("Player/interactingState")

# Stores this current tile state
var tileState = "Tillable"

# Stores any object colliding this tile
var collision = []

# Called every 1/60s (1 frame) 
# Set the text of this state (prototype, later will change the sprite) to the state it is on
# Enters the state machine so that player can interact with this tile
func _process(delta):
	get_node("Label").text = tileState
	if collision.size() > 0:
		enter()

# Updates the tilestate
func change_tile_state(tileState):
	self.tileState = tileState

# Calls the corresponding state machine so that player can interact
func enter():
	if Game.currentInteractingState != "None" and interactingState.get_node(Game.currentInteractingState) != null:
		interactingState.get_node(Game.currentInteractingState).interact(self, tileState, collision)

# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
