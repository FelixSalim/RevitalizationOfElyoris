extends Area2D

# Declares class
class_name TillableLand

# Gets player state onready
@onready var interactingState = get_parent().get_node("Player/interactingState")

var tileState = "Tillable"
var collision = []

func _process(delta):
	get_node("Label").text = tileState
	if collision.size() > 0:
		enter()

func change_tile_state(tileState):
	self.tileState = tileState

func enter():
	if Game.currentInteractingState != "None" and interactingState.get_node(Game.currentInteractingState) != null:
		interactingState.get_node(Game.currentInteractingState).interact(self, tileState, collision)

func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
