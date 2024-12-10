# Inherit State Class
extends MovementState

# IdleState Class
class_name NotificationState

# Stores current notification popup state
var inNotif = true

var notif = preload("res://UI/Notification.tscn")

func _ready():
	var notification = notif.instantiate()
	notification.set_notification("Hi, this is a mailbox")
	notification.name = "Notification"
	get_parent().get_parent().get_node("Control/UI").add_child(notification)

# Read user input, if player pressed confirm, stop notification
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_parent().get_parent().get_node("Control/UI/Notification").queue_free()
		inNotif = false

# Movement Handling, Change State to Run, calls the function stored in changeState (a.k.a change_state)
func move_left():
	if not inNotif:
		changeState.call("run")

func move_right():
	if not inNotif:
		changeState.call("run")

func move_up():
	if not inNotif:
		changeState.call("run")

func move_down():
	if not inNotif:
		changeState.call("run")
