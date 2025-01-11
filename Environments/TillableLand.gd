extends Area2D

# Declares class
class_name TillableLand

# Gets player state and tile sprite onready
@onready var interactingState = get_node("../../Player/Player/interactingState")
@onready var tileSprite = get_node("Sprite2D")

# Stores this current tile state
var tileState = "Tillable"

# Stores watered state
var isWatered = false

# Stores any object colliding this tile
var collision = []

# Called every 1/60s (1 frame) 
# Set the text of this state (prototype, later will change the sprite) to the state it is on
# Enters the state machine so that player can interact with this tile
func _process(delta):
	# If it has a plant already, collCheck needs an extra to avoid plant sprite collision
	var collCheck = 0
	if tileState == "Planted":
		collCheck = 1
	if collision.size() > collCheck:
		print(collision)
		enter()
	
	# Changed texture depending on tile state
	if(tileState != "Tillable" and not isWatered):
		tileSprite.texture = load("res://Assets/EnvironmentSprites/Dry Land-Sheet.png")
		tileSprite.scale = Vector2(1, 1)
	elif (tileState != "Tillable" and isWatered):
		tileSprite.texture = load("res://Assets/EnvironmentSprites/Wet Land-Sheet.png")
		tileSprite.scale = Vector2(6, 6)
	elif tileState == "Tillable":
		tileSprite.texture = load("res://Assets/EnvironmentSprites/Normal Land-Sheet.png")

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
