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
	playerAnimation.stop()
	player.isInteracting = true
	var notification = notif.instantiate()
	notification.name = "Notification"
	player.get_node("Control/UI").add_child(notification)

# Read user input, if player pressed confirm, hide notification, if player interact with it again, show the notification
func _input(event):
	if event.is_action_pressed("ui_accept") and player.isInteracting:
		player.get_node("Control/UI/Notification").hide()
		player.isInteracting = false
		if use == "sleep":
			get_node("../../../../CanvasModulate").next_day()
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
		changeState.call("run")
		player.get_node("Control/UI/Notification").queue_free()

func move_right():
	if not player.isInteracting:
		changeState.call("run")
		player.get_node("Control/UI/Notification").queue_free()

func move_up():
	if not player.isInteracting:
		changeState.call("run")
		player.get_node("Control/UI/Notification").queue_free()

func move_down():
	if not player.isInteracting:
		changeState.call("run")
		player.get_node("Control/UI/Notification").queue_free()
