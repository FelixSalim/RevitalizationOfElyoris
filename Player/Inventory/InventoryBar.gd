extends Node2D

var defaultStyleBox = StyleBoxFlat.new()
var selectedStyleBox = StyleBoxFlat.new()

# When ready, sets stylebox and load player items into screen
func _ready():
	defaultStyleBox.set("bg_color", Color(0.6, 0.6, 0.6))
	selectedStyleBox.set("bg_color", Color(1, 0, 0))
	for i in range(len(Game.inventory)):
		if Game.inventory[i] != -1:
			var item = load(ItemData.item[Game.inventory[i]]["Location"]).instantiate()
			item.position.x = 81 + i * 184
			item.position.y = 68
			get_node("Slot" + str(i+1)).add_child(item)

# Move to the slot every frame and check for tools
func _process(delta):
	get_child(Game.selected + 1).get_child(0).add_theme_stylebox_override("panel", selectedStyleBox)
	# if child is more than 1, it has a tool
	if get_child(Game.selected + 1).get_child_count() > 1:
		var tool = get_child(Game.selected + 1).get_child(1)
		if ItemData.item[tool.itemID]["Name"] == "Hoe": # change to the corresponding state
			get_parent().get_parent().get_parent().change_interacting_state("till")
	else: # else change back to the none state
		get_parent().get_parent().get_parent().change_interacting_state("none")

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
	hide_all()
	
# Deselect all inventory item
func hide_all():
	for i in get_child_count() - 1:
		get_child(i + 1).get_child(0).add_theme_stylebox_override("panel", defaultStyleBox)
