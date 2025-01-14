extends Area2D

# Declares class
class_name TillableLand

# Gets player state and tile sprite onready
@onready var interactingState = get_node("../../Environments/Player/Player/interactingState")
@onready var tileSprite = get_node("Sprite2D")

# Stores this current tile state
var tileState = "Tillable"

# Stores watered state
var isWatered = false

# Stores any object colliding this tile
var collision = []

# Stores land id
var id

func _ready():
	# Get land id based on the number in name
	var i = 1
	while self.name.right(i).is_valid_int():
		i += 1
		
	id = int(self.name.right(i - 1)) 
	
	# Get land data
	if Game.plot.has(str(id - 1)):
		var landData = Game.plot[str(id - 1)]
	
		# Set land data
		self.tileState = landData["tileState"]
		self.isWatered = landData["isWatered"]
		
		# If it is planted
		if tileState == "Planted":
			var plant
			# Load plant
			if landData["plant"] == "TurnipPlant":
				plant = preload("res://Plants/TurnipPlant.tscn").instantiate()
				self.add_child(plant)
				plant.progress = landData["plantProgress"]

# Called every 1/60s (1 frame) 
# Set the text of this state (prototype, later will change the sprite) to the state it is on
# Enters the state machine so that player can interact with this tile
func _process(delta):
	# If it has a plant already, collCheck needs an extra to avoid plant sprite collision
	var collCheck = 0
	if tileState == "Planted":
		collCheck = 1
	if collision.size() > collCheck:
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

	var plant = null
	var plantProgress

	if tileState != "Planted":
		plantProgress = 0
	else:
		plant = get_child(2).name
		plantProgress = get_child(2).progress

	# Keep track of plot data
	var data = {
		"tileState" : tileState,
		"isWatered" : isWatered,
		"plant" : plant,
		"plantProgress" : plantProgress
	}
	
	Game.plot[str(id - 1)] = data
	
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
