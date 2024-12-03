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

# Movement Handling, Set velocity to corresponding movement direction, also plays animation accordingly
func move_left():
	player.velocity.x -= Input.get_action_strength("ui_left")
	if Input.get_action_strength("ui_left") > Input.get_action_strength("ui_up") and Input.get_action_strength("ui_left") > Input.get_action_strength("ui_down"):
		playerAnimation.play("Idle Left")
		hitboxAnimation.play("Interact Left")

func move_right():
	player.velocity.x += Input.get_action_strength("ui_right")
	if Input.get_action_strength("ui_right") > Input.get_action_strength("ui_up") and Input.get_action_strength("ui_right") > Input.get_action_strength("ui_down"):
		playerAnimation.play("Idle Right")
		hitboxAnimation.play("Interact Right")

func move_up():
	player.velocity.y -= Input.get_action_strength("ui_up")
	if Input.get_action_strength("ui_up") > Input.get_action_strength("ui_left") and Input.get_action_strength("ui_up") > Input.get_action_strength("ui_right"):
		playerAnimation.play("Idle Up")
		hitboxAnimation.play("Interact Up")

func move_down():
	player.velocity.y += Input.get_action_strength("ui_down")
	if Input.get_action_strength("ui_down") > Input.get_action_strength("ui_left") and Input.get_action_strength("ui_down") > Input.get_action_strength("ui_right"):
		playerAnimation.play("Idle Down")
		hitboxAnimation.play("Interact Down")
