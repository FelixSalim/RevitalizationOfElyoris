extends Node2D

# Get player
@onready var player = get_parent().get_parent().get_parent()

# When ready, sets stylebox and load player items into screen
func _ready():
	hide_all()
	for i in range(len(Game.inventory)):
		if Game.inventory[i] != -1:
			var item = load(ItemData.item[Game.inventory[i]]["Location"]).instantiate()
			item.position.x = 89 + i * 125
			item.position.y = 88
			get_node("Slots/Slot" + str(i+1)).add_child(item)

# Move to the slot every frame and check for tools
func _process(delta):
	get_node("Slots").get_child(Game.selected).get_child(0).visible = true
	# if child is more than 1, it has a tool
	if get_node("Slots").get_child(Game.selected).get_child_count() > 1:
		var tool = get_node("Slots").get_child(Game.selected).get_child(1)
		# change to the corresponding state if the tool is selected
		if ItemData.item[tool.itemID]["Name"] == "Hoe" and Game.currentInteractingState != "till": 
			player.change_interacting_state("till")
		elif ItemData.item[tool.itemID]["Name"] == "WateringCan" and Game.currentInteractingState != "water":
			player.change_interacting_state("water")
		elif ItemData.item[tool.itemID]["Name"] == "TurnipSeed" and Game.currentInteractingState != "seed":
			player.change_interacting_state("seed")
	else: # else change back to the none state
		player.change_interacting_state("none")

# Get player input and move to selected slot
func _input(event):
	if event.is_action_pressed("ui_1"):
		Game.selected = 0	
	if event.is_action_pressed("ui_2"):
		Game.selected = 1
	if event.is_action_pressed("ui_3"):
		Game.selected = 2
	if event.is_action_pressed("ui_4"):
		Game.selected = 3
	if event.is_action_pressed("ui_5"):
		Game.selected = 4
	if event.is_action_pressed("ui_6"):
		Game.selected = 5
	if event.is_action_pressed("ui_7"):
		Game.selected = 6
	if event.is_action_pressed("ui_8"):
		Game.selected = 7
	hide_all()
	
# Deselect all inventory item
func hide_all():
	for i in get_node("Slots").get_child_count():
		get_node("Slots").get_child(i).get_child(0).visible = false
