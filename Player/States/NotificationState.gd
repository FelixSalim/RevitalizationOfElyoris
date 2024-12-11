# Inherit State Class
extends MovementState

# IdleState Class
class_name NotificationState

# Load the notification
var notif = preload("res://UI/Notification.tscn")

# Instantiate the notification
func _ready():
	playerAnimation.stop()
	player.isInteracting = true
	var notification = notif.instantiate()
	notification.name = "Notification"
	get_parent().get_parent().get_node("Control/UI").add_child(notification)

# Read user input, if player pressed confirm, stop notification
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().get_parent().get_node("Control/UI/Notification").queue_free()
		player.isInteracting = false

# Movement Handling, Change State to Run, calls the function stored in changeState (a.k.a change_state)
# Also makes sure that player is not interacting
func move_left():
	if not player.isInteracting:
		changeState.call("run")

func move_right():
	if not player.isInteracting:
		changeState.call("run")

func move_up():
	if not player.isInteracting:
		changeState.call("run")

func move_down():
	if not player.isInteracting:
		changeState.call("run")
