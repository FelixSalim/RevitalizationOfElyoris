# Inherit State Class
extends MovementState

# IdleState Class
class_name NotificationState

# Load the notification
var notif = preload("res://UI/Notification.tscn")

# Stores notification usage

var use

# Initialize use
func initialize(use):
	self.use = use

# Instantiate the notification when it is called


func _ready():
	# Stop unwanted animation
	if playerAnimation.current_animation not in ["Fade Out", "Idle Down", ""]:
		playerAnimation.stop()
	
	# Player is interacting
	player.isInteracting = true
	
	# Instantiate notification
	var notification = notif.instantiate()
	notification.name = "Notification"
	player.get_node("Control/UI").add_child(notification)

# Handles sleep notification
func sleep_handler():
	var stream = player.get_node("../../../AudioStreamPlayer")
	
	# Set use to postSleep
	use = "postSleep"
	
	# Hides player UI
	player.get_node("Control/UI").hide()
	
	# Move to next day
	var moneyMade = player.get_node("../../../CanvasModulate").next_day()
	
	# Play fade in animation
	playerAnimation.play("Fade In")
	
	# Momentarily stop music
	stream.stop()
	
	# Wait for 1 seconds
	await get_tree().create_timer(1).timeout
	
	# Move player to the bed
	var playerCam = player.get_node("Camera2D")
	player.global_position = Settings.GlobalPositions["Bed"]
	playerCam.limit_left = Settings.LoadingZones["House"]["Left"]
	playerCam.limit_bottom = Settings.LoadingZones["House"]["Bottom"]
	playerCam.limit_right = Settings.LoadingZones["House"]["Right"]
	playerCam.limit_top = Settings.LoadingZones["House"]["Top"]
	
	# reset player
	playerAnimation.play("Idle Down")
	hitboxAnimation.play("Interact Down")

	# Wait for 1 seconds
	await get_tree().create_timer(0.4).timeout
	
	# Play fade out animation
	playerAnimation.play("Fade Out")
	
	# Play music again
	stream.play()
	
	# Wait for 0.6 seconds
	await get_tree().create_timer(0.6).timeout
	
	# Show player UI again
	player.get_node("Control/UI").show()
	
	# for presentation purposes
	if player.get_node("Control/UI/InventoryBar").visible == false:
		player.get_node("Control/UI/InventoryBar").visible = true
	
	# Reset state
	player.get_node("Control/UI/Notification").queue_free()
	
	# Wait for 0.2 seconds
	await get_tree().create_timer(0.2).timeout
	
	# Player no longer in a cutscene
	changeState.call("idle")
	player.isInteracting = false
	
	# If money is made notify the player
	if moneyMade > 0:
		player.notify_money(moneyMade)

# Read user input, if player pressed confirm, hide notification, if player interact with it again, show the notification
func _input(event):
	if event.is_action_pressed("ui_accept") and player.isInteracting and use != "postSleep":
		player.get_node("Control/UI/Notification").hide()
		# If player is interacting with a bed
		if use == "sleep":
			sleep_handler()
		elif use == "store" and Game.inventory[Game.selected] >= 100:
			var item = ItemData.harvest[Game.inventory[Game.selected] - 100]
			Game.inventoryAmount[Game.selected] -= 1
			Game.items.append(item)
			player.isInteracting = false
			if Game.inventoryAmount[Game.selected] == 0:
				player.get_node("Control/UI/Notification").set_notification("You ran out of items")
		else:
			player.isInteracting = false
	elif event.is_action_pressed("ui_cancel") and player.isInteracting and use != "store":
		player.get_node("Control/UI/Notification").hide()
		player.isInteracting = false
	elif event.is_action_pressed("ui_accept") and not player.isInteracting:
		if player.has_node("Control/UI/Notification"):
			player.get_node("Control/UI/Notification").show()
			player.isInteracting = true
			
# Movement Handling, Change State to Run, calls the function stored in changeState (a.k.a change_state)
# Also makes sure that player is not interacting and free notification after change of state
func move_left():
	if not player.isInteracting:
		player.get_node("Control/UI/Notification").queue_free()
		changeState.call("run")

func move_right():
	if not player.isInteracting:
		player.get_node("Control/UI/Notification").queue_free()
		changeState.call("run")

func move_up():
	if not player.isInteracting:
		player.get_node("Control/UI/Notification").queue_free()
		changeState.call("run")

func move_down():
	if not player.isInteracting:
		player.get_node("Control/UI/Notification").queue_free()
		changeState.call("run")
