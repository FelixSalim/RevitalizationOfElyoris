# Inherit State Class
extends State

# RunState class
class_name RunState

# Get Input, Detects when player stop moving, if so, change state to idle
func get_input():
	if Input.is_action_just_released("ui_left"):
		changeState.call("idle")
	if Input.is_action_just_released("ui_right"):
		changeState.call("idle")
	if Input.is_action_just_released("ui_up"):
		changeState.call("idle")
	if Input.is_action_just_released("ui_down"):
		changeState.call("idle")

# Run get_input every fixed interval
func _physics_process(delta):
	get_input()

# Movement Handling, Set velocity to corresponding movement direction
func move_left():
	player.velocity.x -= Input.get_action_strength("ui_left")

func move_right():
	player.velocity.x += Input.get_action_strength("ui_right")

func move_up():
	player.velocity.y -= Input.get_action_strength("ui_up")

func move_down():
	player.velocity.y += Input.get_action_strength("ui_down")
