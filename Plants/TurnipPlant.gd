extends Area2D

# Stores plant sprite
@onready var plant = $Label # Subject to change when sprite is ready

# Stores plant stage
var stage = 1

# Stores plant progress
var progress = 1

# Stores any collision
var collision = []

# Update sprites accordingly and check collision
func _process(delta):
	plant.text = "Stage " + str(stage)
	
	# Update stage
	if progress == 2:
		stage = 2
	elif progress == 4:
		stage = 3
	elif progress == 5:
		stage = 4
		
	# If player is in collision prepare for harvest
	if len(collision) > 1:
		enter()

func enter():
	# Harvest prompted
	if Input.is_action_just_pressed("ui_accept") and get_node("../../../Environments/Player/Player/InteractBox") in collision and stage == 4 and (Game.inventory[Game.selected] == -1 or Game.inventory[Game.selected] == 100):
		harvest()

func harvest():
	var player = get_node("../../../Environments/Player/Player")
	
	# Play harvest animation
	player.change_moving_state("idle")
	if player.lastDir == "left":
		player.get_node("AnimationPlayer").play("PickLeft")
	elif player.lastDir == "right":
		player.get_node("AnimationPlayer").play("PickRight")
	elif player.lastDir == "up":
		player.get_node("AnimationPlayer").play("PickUp")
	elif player.lastDir == "down":
		player.get_node("AnimationPlayer").play("PickDown")

	# Wait a bit
	await get_tree().create_timer(0.5).timeout

	# Update inventory
	Game.inventory[Game.selected] = 100
	Game.inventoryAmount[Game.selected] += 1
	player.get_node("Control/UI/InventoryBar").load_inventory()
	
	# Return land back to normal
	get_parent().tileState = "Tillable"
	get_parent().isWatered = false
	get_parent().tileSprite.scale = Vector2(1, 1)
	
	# Remove plant
	self.queue_free()

# Advance to next stage
func next_progress():
	if self.progress < 6:
		self.progress += 1

# When a collision occurs, add the collision to the array
func _on_area_entered(area: Area2D) -> void:
	collision.append(area)

# When a collision no longer exists, remove the collision from the array
func _on_area_exited(area: Area2D) -> void:
	collision.erase(area)
