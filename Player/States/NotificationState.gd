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
	# Hides player UI
	player.get_node("Control/UI").hide()
	
	# Move to next day
	player.get_node("../../CanvasModulate").next_day()
	
	# Play fade in animation
	playerAnimation.play("Fade In")
	
	# Wait for 2 seconds
	await get_tree().create_timer(1).timeout
	
	# Move player to the bed
	var playerCam = player.get_node("Camera2D")
	player.global_position = Vector2(8468, -1554)
	playerCam.limit_left = 7655
	playerCam.limit_bottom = -1149
	playerCam.limit_right = 9003.938
	playerCam.limit_top = -1885.753
	
	# reset player
	playerAnimation.play("Idle Down")
	hitboxAnimation.play("Interact Down")

	# Wait for 1 seconds
	await get_tree().create_timer(0.4).timeout
	
	# Play fade out animation
	playerAnimation.play("Fade Out")
	
	# Wait for 1 seconds
	await get_tree().create_timer(0.6).timeout
	
	# Show player UI again
	player.get_node("Control/UI").show()
	
	# Reset state
	player.get_node("Control/UI/Notification").queue_free()
	changeState.call("idle")
	
	# Player no longer in a cutscene
	player.isInteracting = false

# Read user input, if player pressed confirm, hide notification, if player interact with it again, show the notification
func _input(event):
	if event.is_action_pressed("ui_accept") and player.isInteracting:
		player.get_node("Control/UI/Notification").hide()
		if use == "sleep":
			sleep_handler()
		else:
			player.isInteracting = false
	elif event.is_action_pressed("ui_cancel") and player.isInteracting:
		player.get_node("Control/UI/Notification").hide()
		player.isInteracting = false
	elif event.is_action_pressed("ui_accept") and not player.isInteracting:
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
