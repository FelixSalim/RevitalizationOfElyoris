extends Node2D

# Get player
@onready var player = get_node("../../..")

# When ready, sets stylebox and load player items into screen
func _ready():
	hide_all()
	load_inventory()

# Load inventory
func load_inventory():
	for i in range(len(Game.inventory)):
		var item
		if Game.inventory[i] != -1:
			if Game.inventory[i] >= 0 and Game.inventory[i] < 100:
				item = load(ItemData.item[Game.inventory[i]]["Location"]).instantiate()
			elif Game.inventory[i] >= 100:
				item = load(ItemData.harvest[Game.inventory[i] - 100]["Location"]).instantiate()
			item.position = Vector2(89 + i * 125, 88)
			item.scale = Vector2(0.75, 0.75)
			get_node("Slots/Slot" + str(i+1)).add_child(item)

# Update amount to show
func update_amount():
	for i in range(len(Game.inventoryAmount)):
		# Different Amount for watering cans
		if Game.inventory[i] != 1:
			if Game.inventoryAmount[i] > 0:
				get_node("Slots").get_child(i).get_child(1).text = str(Game.inventoryAmount[i])
				get_node("Slots").get_child(i).get_child(1).visible = true
			else:
				# If it doesn't exist remove it
				if get_node("Slots").get_child(i).get_child_count() > 2:
					get_node("Slots").get_child(i).get_child(2).free()
				Game.inventory[i] = -1
		else:
			get_node("Slots").get_child(i).get_child(1).text = str(get_node("Slots").get_child(i).get_child(2).water) + "%"
			get_node("Slots").get_child(i).get_child(1).visible = true
	
# Move to the slot every frame and check for tools and item amounts
func _process(delta):
	# Check for amounts
	update_amount()
	
	get_node("Slots").get_child(Game.selected).get_child(0).visible = true
	# if child is more than 1, it has a tool and not id for harvestables items
	if get_node("Slots").get_child(Game.selected).get_child_count() > 2 and Game.inventory[Game.selected] < 100:
		tool_check()
	else: # else change back to the none state
		player.change_interacting_state("none")
		# If player is holding an item (harvest etc)
		item_check()
	
	# Update player sprite accordingly
	update_holding_sprite()

# Check for tools
func tool_check():
	var tool = get_node("Slots").get_child(Game.selected).get_child(2)
	# change to the corresponding state if the tool is selected
	if Game.inventory[Game.selected] != -1:
		if ItemData.item[tool.itemID]["Name"] == "Hoe" and Game.currentInteractingState != "till": 
			player.change_interacting_state("till")
		elif ItemData.item[tool.itemID]["Name"] == "WateringCan" and Game.currentInteractingState != "water":
			player.change_interacting_state("water")
		elif ItemData.item[tool.itemID]["Name"] == "TurnipSeed" and Game.currentInteractingState != "seed":
			player.change_interacting_state("seed")
		player.isHolding = false

# Check for items
func item_check():
	if Game.inventory[Game.selected] >= 100:
		player.isHolding = true
	else:
		player.isHolding = false

# Update player holding sprite
func update_holding_sprite():
	# If player is holding instantiate the node if it is a different node or no node exist
	if player.isHolding and not player.isInteracting:
		var item = load(ItemData.harvest[Game.inventory[Game.selected] - 100]["Location"]).instantiate()
		item.name = "HoldItem"
		if player.has_node("HoldItem"):
			if player.get_node("HoldItem").harvestID != item.harvestID:
				player.get_node("HoldItem").queue_free()
				player.get_node("Sprite2D").add_sibling(item, true)
				player.get_node("HoldItem").position = Vector2(0, -65)
		else:
			player.get_node("Sprite2D").add_sibling(item, true)
			player.get_node("HoldItem").position = Vector2(0, -65)
	else:
		# If an item is held reset
		if player.has_node("HoldItem"):
			player.get_node("HoldItem").queue_free()
		

# Get player input and move to selected slot if player is not interacting
func _input(event):
	if not player.isInteracting:
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
		get_node("Slots").get_child(i).get_child(1).visible = false
